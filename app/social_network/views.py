import oauth2_provider
from rest_framework import viewsets, permissions, status, generics
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, JSONParser
from rest_framework.views import APIView
from django.db import IntegrityError
from .models import *
from .serializers import *
from .ultis import IsOwner, StandardResultsSetPagination, IsCurrentUser, send_push_message, create_hash_by_RSA, \
    send_request_to_momo, validate_token_login_by_gg, create_access_token_with_user
from datetime import datetime
from django.db.models import Q
from google.oauth2 import id_token
from google.auth.transport import requests
from oauth2_provider.views.mixins import OAuthLibMixin
from oauth2_provider.models import AbstractAccessToken, AccessToken


CLIENT_ID = "972868105319-oc23en8rdr7bg9h9ja8agt48btuu32m4.apps.googleusercontent.com"

class UserViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.UpdateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]

    def get_permissions(self):
        if self.action in ['create', 'login_by_gg', 'login_by_fb']:
            return [permissions.AllowAny()]
        return [permissions.IsAuthenticated(), IsCurrentUser()]

    @action(methods=['get'], detail=False, url_path='current-user')
    def get_current_user(self, request, pk=None):
        return Response(self.serializer_class(request.user).data)

    @action(methods=['get'], detail=True, url_path='base-info')
    def get_user(self, request, pk=None):
        try:
            user = User.objects.get(pk=pk)
            serializer = UserBaseInforSerializer(user)
            return Response(serializer.data,
                            status=status.HTTP_200_OK)

        except User.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=False, url_path='push-token')
    def post_push_token(self, request, pk=None):
        try:
            push_token = request.data.get('push_token')
            if push_token:
                user = User.objects.get(pk=request.user.id)
                user.push_token = push_token
                user.save()

                serializer = UserSerializer(user)
                return Response(serializer.data,
                                status=status.HTTP_200_OK)
            return Response(status=status.HTTP_400_BAD_REQUEST)

        except User.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=False, url_path='delete-token')
    def delete_push_token(self, request, pk=None):
        try:
            user = User.objects.get(pk=request.user.id)
            user.push_token = ""
            user.save()
            return Response(data={}, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=False, url_path='login-by-gg', parser_classes=[JSONParser, ])
    def login_by_gg(self, request):
        auth = request.data.get('auth')
        token = auth.get("accessToken")

        try:
            data = validate_token_login_by_gg(token)
            is_verified = data.get("email_verified")
            if is_verified:
                user = User.objects.filter(username=request.data.get('email')).first()
                if not user:
                    user.first_name = request.data.get('firstName')
                    user.last_name = request.data.get('lastName')
                    user.username = request.data.get('email')
                    user.email = request.data.get('email')
                    user.avatar = request.data.get('photoURL')
                    user.password = "null"
                    user.save()
                data_res = create_access_token_with_user(user)
                return Response(data=data_res,
                                status=status.HTTP_200_OK)
        except ValueError:
            return Response(status=status.HTTP_400_BAD_REQUEST)


class PostViewSet(viewsets.ModelViewSet):
    serializer_class = PostSerializer
    parser_classes = [MultiPartParser, ]

    def get_permissions(self):
        if self.action in ['list', 'retrieve']:
            return [permissions.AllowAny()]
        elif self.action in ['update', 'partial_update', 'destroy']:
            return [permissions.IsAuthenticated(), IsOwner()]
        return [permissions.IsAuthenticated()]

    def create(self, request):
        content = request.data.get('content')
        hashtag = request.data.get('hashtag')
        images = request.FILES.getlist('images')

        if request.user.is_authenticated:
            user = request.user

        post = Post.objects.create(content=content, user=user)

        if hashtag:
            list_hashtag = hashtag.split(',')
            for name in list_hashtag:
                post.hashtag.add(HashTagPost.objects.get_or_create(name=name)[0])

        for image in images:
            PostImage.objects.create(image=image, post=post)

        serializer = PostSerializer(post)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    def partial_update(self, request, pk=None, *args, **kwargs):
        hashtag = request.data.get('hashtag')
        images = request.FILES.getlist('images')
        content = request.data.get('content')
        post = Post.objects.get(pk=pk)

        if content:
            post.content = content

        if hashtag:
            post.hashtag.all().delete()
            list_hashtag = hashtag.split(',')
            for name in list_hashtag:
                post.hashtag.add(HashTagPost.objects.get_or_create(name=name)[0])

        if (images):
            post.post_images.all().delete()
            for image in images:
                PostImage.objects.create(image=image, post=post)

        post.save()

        serializer = PostSerializer(post)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    def get_queryset(self):
        id = self.request.query_params.get('id', None)
        hashtag = self.request.query_params.get('hashtag', None)
        user_name = self.request.query_params.get('user_name', None)
        content = self.request.query_params.get('content', None)

        queryset = Post.objects.filter(active=True)

        if hashtag:
            queryset = queryset.filter(hashtag__in=HashTagPost.objects.filter(name__contains=hashtag))
        if user_name:
            queryset = queryset.filter(
                Q(user__first_name__icontains=user_name) | Q(user__last_name__contains=user_name))
        if content:
            queryset = queryset.filter(content__icontains=content)
        if id:
            queryset = queryset.filter(user__id=id)
        return queryset

    @action(methods=['get'], detail=False, url_path='owner')
    def get_owner_post(self, request):
        try:
            posts = Post.objects.filter(user__id=request.user.id)
            page = self.paginate_queryset(posts)
        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(posts, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='increase-vote')
    def increase_vote(self, request, pk=None):
        try:
            post = self.get_object()
            post.like.add(request.user)
            post.save()

            owner_post = post.user
            if owner_post.push_token and owner_post.push_token != "none":
                title = request.user.get_full_name() + " did like your post"
                data = {"id": post.id, "obj": "post"}
                send_push_message(token=owner_post.push_token,
                                  title=title,
                                  message=post.content,
                                  extra=data)

        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostSerializer(post)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='decrease-vote')
    def decrease_vote(self, request, pk=None):
        try:
            post = Post.objects.get(pk=pk)
            post.like.remove(request.user)
            post.save()

        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostSerializer(post)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='comments')
    def add_comment(self, request, pk=None):
        content = request.POST['content']
        try:
            post = self.get_object()
            comment = PostComment.objects.create(content=content, post=post, user=request.user)
            post.count_comment = post.count_comment + 1;
            post.save()

            owner_post = post.user
            if owner_post.push_token and owner_post.push_token != "none":
                title = request.user.get_full_name() + " did comment your post"
                data = {"id": str(post.id), "obj": "post"}
                send_push_message(token=owner_post.push_token,
                                  title=title,
                                  message=content,
                                  extra=data)

        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostCommentSerializer(comment)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)


class PostCommentAPIView(APIView):
    def get_permissions(self):
        if self.request.method == 'GET':
            return [permissions.AllowAny()]

        return [permissions.IsAuthenticated()]

    def get(self, request, post_id):
        try:
            comments = PostComment.objects.filter(post__id=post_id)
        except PostComment.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostCommentSerializer(comments, many=True)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)


class CategoryViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = CategoryAuction.objects.all()
    serializer_class = CategoryAuctionSerializer
    pagination_class = StandardResultsSetPagination


class AuctionViewSet(viewsets.ModelViewSet):
    serializer_class = AuctionSerializer
    parser_classes = [MultiPartParser, ]
    basename = "/"

    def get_queryset(self):
        title = self.request.query_params.get('title', None)
        category = self.request.query_params.get('category', None)
        base_price = self.request.query_params.get('base_price', None)
        user_name = self.request.query_params.get('user_name', None)

        queryset = Auction.objects.filter(active=True, status_auction=StatusAuction.auction)
        if title:
            queryset = queryset.filter(title__icontains=title)
        if category:
            queryset = queryset.filter(category=category)
        if base_price:
            queryset = queryset.filter(base_price__gt=base_price)
        if user_name:
            queryset = queryset.filter(
                Q(user__first_name__icontains=user_name) | Q(user__last_name__contains=user_name))

        queryset = queryset.select_related("user").select_related("buyer").select_related("category").select_related(
            "payment_method")

        return queryset

    def get_permissions(self):
        if self.action in ['list', 'retrieve']:
            return [permissions.AllowAny()]
        if self.action in ['create']:
            return [permissions.IsAuthenticated()]
        if self.action in ['update', 'partial_update', 'destroy']:
            return [permissions.IsAuthenticated(), IsOwner()]
        return [permissions.IsAuthenticated()]

    def create(self, request):
        form_data = dict(request.POST.dict())
        category_id = form_data.pop('category')
        payment_method_id = form_data.pop('payment_method')

        category = CategoryAuction.objects.get(id=category_id)
        payment = PaymentMethod.objects.get(id=payment_method_id)
        auction = Auction.objects.create(user=request.user, category=category, payment_method=payment, **form_data)

        if request.FILES:
            images = request.FILES.getlist('images')
            for image in images:
                AuctionImage.objects.create(image=image, auction=auction)

        serializer = AuctionSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    def partial_update(self, request, pk, *args, **kwargs):
        auction = Auction.objects.get(pk=pk)
        data = request.data
        images = request.FILES.getlist('images')
        if (images):
            AuctionImage.objects.filter(auction__id=auction.id).delete()
            for image in images:
                AuctionImage(image=image, auction_id=auction.id).save()

        auction.title = data['title']
        auction.content = data['content']
        auction.base_price = data['base_price']
        auction.condition = data['condition']
        auction.deadline = data['deadline']
        auction.category = CategoryAuction.objects.get(pk=data['category'])
        auction.payment_method = PaymentMethod.objects.get(pk=data['payment_method'])
        auction.save()

        serializer = AuctionSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    def retrieve(self, request, pk, *args, **kwargs):
        auction = Auction.objects.get(pk=pk)

        serializer = AuctionSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    def destroy(self, request, pk, *args, **kwargs):
        try:
            auction = Auction.objects.get(pk=pk)
            auction.delete()
            return Response(data={}, status=status.HTTP_200_OK)
        except Auction.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    @action(methods=['get'], detail=False, url_path='owner')
    def get_owner_auction(self, request):
        try:
            auctions = Auction.objects.filter(user__id=request.user.id)
            page = self.paginate_queryset(auctions)
        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(auctions, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    @action(methods=['get'], detail=False, url_path='auction_join')
    def get_join_auction(self, request):
        try:
            user = request.user
            auctions = Auction.objects.filter(auction_comments__user__id=user.id)
            page = self.paginate_queryset(auctions)
        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(auctions, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='increase-vote')
    def increase_vote(self, request, pk=None):
        try:
            auction = Auction.objects.get(pk=pk)
            auction.like.add(request.user)
            auction.save()

            owner_auction = auction.user
            if owner_auction.push_token and owner_auction.push_token != "none":
                title = request.user.get_full_name() + " did like your auction"
                data = {"id": str(auction.id), "obj": "auction"}
                send_push_message(token=owner_auction.push_token,
                                  title=title,
                                  message=auction.content,
                                  extra=data)

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='decrease-vote')
    def decrease_vote(self, request, pk=None):
        try:
            auction = Auction.objects.get(pk=pk)
            auction.like.remove(request.user)
            auction.save()

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='comments')
    def add_comment(self, request, pk=None):
        content = request.POST['content']
        price = request.POST['price']

        defaults = {}
        if content:
            defaults["content"] = content
        if price:
            defaults["price"] = price

        try:
            comment, created = AuctionComment.objects.update_or_create(
                user=request.user, auction=self.get_object(),
                defaults=defaults,
            )

            auction = self.get_object()
            title = request.user.get_full_name()
            if created:
                auction.count_comment = auction.count_comment + 1;
                auction.save()
                title += " did comment in your auction"
            else:
                title += " did edit comment in your auction"

            owner_auction = auction.user
            if owner_auction.push_token and owner_auction.push_token != "none":
                data = {"id": str(auction.id), "obj": "auction"}
                send_push_message(token=owner_auction.push_token,
                                  title=title,
                                  message=auction.title,
                                  extra=data)

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionCommentSerializer(comment)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='fail-auction', permission_classes=[IsOwner()])
    def success_auction(self, request, pk=None):
        try:
            auction = Auction.objects.get(pk=pk)
            if auction.status_auction == StatusAuction.success:
                return Response(status=status.HTTP_400_BAD_REQUEST, data={"error_msg": "This auction had success."})

            auction.status_auction = StatusAuction.fail
            auction.save()

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path=r'comment/(?P<comment_id>\d+)/state/(?P<state>\w+)',
            permission_classes=[IsOwner()])
    def set_status_transaction(self, request, *args, **kwargs):
        comment_id = kwargs.get('comment_id')
        auction_id = kwargs.get('pk')

        try:
            state_comment = StatusAuction[kwargs.get('state')]
            if state_comment == StatusTransaction.none:
                return Response(status=status.HTTP_400_BAD_REQUEST,
                                data={"error_msg": "You only choose state auction comment: in_process, fail, success"})
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"error_msg": "Wrong state of StatusAuction"})

        auction = Auction.objects.get(pk=auction_id)
        comment = AuctionComment.objects.get(pk=comment_id)

        if state_comment == StatusTransaction.in_process and comment.status_transaction == StatusTransaction.none:
            check_exsit = auction.auction_comments.filter(status_transaction=StatusAuction.in_process)
            if check_exsit.exists():
                return Response(status=status.HTTP_400_BAD_REQUEST, data={"error_msg": "Any comment was in_process"})
            comment.status_transaction = state_comment
            auction.status_auction = StatusAuction.in_process
        elif state_comment == StatusTransaction.fail and comment.status_transaction == StatusTransaction.in_process:
            comment.status_transaction = state_comment
            auction.status_auction = StatusAuction.auction
        elif state_comment == StatusTransaction.success and comment.status_transaction == StatusTransaction.in_process:
            comment.status_transaction = state_comment
            auction.status_auction = StatusAuction.success
            auction.accept_price = comment.price
            auction.buyer = comment.user
            auction.date_success = datetime.now()
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST,
                            data={"error_msg": "State of StatusAuction is not suitable"})

        user_serializer = UserBaseInforSerializer(auction.buyer)

        serializer = StatusSerializer(data={"status_auction": auction.status_auction,
                                            "status_transaction": comment.status_transaction,
                                            "auction_id": auction.id,
                                            "comment_id": comment_id,
                                            "date_success": auction.date_success,
                                            "accept_price": auction.accept_price,
                                            "buyer": user_serializer.data})
        if serializer.is_valid():
            comment.save()
            auction.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"error_msg": serializer.errors})


class AuctionCommentAPIView(APIView):
    def get_permissions(self):
        if self.request.method == 'GET':
            return [permissions.AllowAny()]

        return [permissions.IsAuthenticated(), IsOwner()]

    def get(self, request, auction_id):
        try:
            user = request.user
            auction = Auction.objects.get(pk=auction_id)
            if auction.user.id == user.id:
                comments = AuctionComment.objects.filter(auction__id=auction_id)
            else:
                comments = AuctionComment.objects.filter(user=user, auction=auction)

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionCommentSerializer(comments, many=True)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)


class ReportTypeViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = ReportType.objects.all()
    serializer_class = ReportTypeSerializer
    pagination_class = StandardResultsSetPagination


class PostReportViewSet(viewsets.ViewSet, generics.CreateAPIView):
    parser_classes = [JSONParser]
    serializer_class = PostReportSerializer

    def get_permissions(self):
        return [permissions.IsAuthenticated()]

    def create(self, request, *args, **kwargs):
        user = request.user
        content = request.data.get('content')

        try:
            type = ReportType.objects.get(pk=request.data.get('type'))
        except ReportType.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        try:
            post = Post.objects.get(pk=request.data.get('post'))
        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        post_report, created = PostReport.objects.update_or_create(
            defaults={"type": type, "content": content}
            , user=user, post=post)

        serializer = PostReportSerializer(post_report)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)


class AuctionReportViewSet(viewsets.ViewSet, generics.CreateAPIView):
    parser_classes = [JSONParser]
    serializer_class = AuctionReportSerializer

    def get_permissions(self):
        return [permissions.IsAuthenticated()]

    def create(self, request, *args, **kwargs):
        user = request.user
        content = request.data.get('content')

        try:
            type = ReportType.objects.get(pk=request.data.get('type'))
        except ReportType.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        try:
            auction = Auction.objects.get(pk=request.data.get('auction'))
        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        auction_report, created = AuctionReport.objects.update_or_create(
            defaults={"type": type, "content": content}
            , user=user, auction=auction)

        serializer = AuctionReportSerializer(auction_report)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)


class PaymentMethodViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = PaymentMethod.objects.all()
    parser_classes = [JSONParser]
    serializer_class = PaymentMethodSerializer
    pagination_class = StandardResultsSetPagination


class MomoPay(viewsets.ViewSet, generics.CreateAPIView):
    parser_classes = [JSONParser]
    serializer_class = MomoPaySerializer

    def get_permissions(self):
        return [permissions.IsAuthenticated()]

    def create(self, request, *args, **kwargs):
        auction_id = request.data.get('auction_id')
        comment_id = request.data.get('comment_id')
        phonenumber = request.data.get('phonenumber')
        data = request.data.get('momo_token')

        try:
            auction = Auction.objects.get(pk=auction_id)
        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        try:
            comment = AuctionComment.objects.get(pk=comment_id)
        except AuctionComment.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        partnerCode = "MOMOBDAF20201207"
        partnerRefId = "Kanj-auctionId_%s-commentId_%s" % (auction.id, comment.id)  # ma don hang
        customerNumber = phonenumber
        appData = data
        version = "2.0"
        description = "Thanh toan dau gia"
        amount = comment.price
        hash = create_hash_by_RSA({"amount": amount, "partnerRefId": partnerRefId, "partnerCode": partnerCode})

        res = send_request_to_momo({
            "partnerCode": partnerCode,
            "partnerRefId": partnerRefId,
            "customerNumber": customerNumber,
            "appData": appData,
            "hash": hash.decode("utf-8"),
            "version": version,
            "description": description,
            "amount": amount
        })

        if res.get("status") != 0 and res.get("status") != 2132:
            return Response(data=res, status=status.HTTP_400_BAD_REQUEST)

        auction.buyer = comment.user
        auction.accept_price = comment.price
        auction.date_success = datetime.now()
        auction.status_auction = StatusAuction.success
        comment.status_transaction = StatusTransaction.success

        auction.save()
        comment.save()
        user_serializer = UserBaseInforSerializer(auction.buyer)
        serializer = MomoPaySerializer(data={
            "message": res.get("message", "Thanh toán thành công"),
            "auction_id": auction.id,
            "date_success": auction.date_success,
            "accept_price": auction.accept_price,
            "buyer": user_serializer.data,
            "status_auction": auction.status_auction,
            "status_transaction": comment.status_transaction,
            "comment_id": comment.id
        })

        if serializer.is_valid():
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"error_msg": serializer.errors})


class FeedbackViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Feedback.objects.all()
    parser_classes = [JSONParser]
    serializer_class = FeedbackSerializer

    def get_permissions(self):
        return [permissions.IsAuthenticated()]