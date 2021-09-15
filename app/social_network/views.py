from rest_framework import viewsets, permissions, status, generics
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, JSONParser
from rest_framework.views import APIView
from django.db import IntegrityError
from .models import *
from .serializers import *
from .ultis import IsOwner, StandardResultsSetPagination, IsCurrentUser
from datetime import datetime


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.UpdateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()]
        return [permissions.IsAuthenticated(), IsCurrentUser()]

    @action(methods=['get'], detail=False, url_path='current-user')
    def get_current_user(self, request, pk=None):
        return Response(self.serializer_class(request.user).data)


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.filter(active=True)
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

    @action(methods=['get'], detail=False, url_path='owner')
    def get_owner_post(self, request):
        try:
            posts = Post.objects.filter(user__id=request.user.id)

        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostSerializer(posts, many=True)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='increase-vote')
    def increase_vote(self, request, pk=None):
        try:
            post = self.get_object()
            post.like.add(request.user)
            post.save()

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
    queryset = Auction.objects.filter(active=True).select_related("user").select_related("buyer").select_related(
        "category")
    serializer_class = AuctionSerializer
    parser_classes = [MultiPartParser, ]
    basename = "/"

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

        category = CategoryAuction.objects.get(id=category_id)
        auction = Auction.objects.create(user=request.user, category=category, **form_data)

        if request.FILES:
            images = request.FILES.getlist('images')
            for image in images:
                AuctionImage.objects.create(image=image, auction=auction)

        serializer = AuctionSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['get'], detail=False, url_path='owner')
    def get_owner_post(self, request):
        try:
            auctions = Auction.objects.filter(user__id=request.user.id)

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionSerializer(auctions, many=True)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='increase-vote')
    def increase_vote(self, request, pk=None):
        try:
            auction = Auction.objects.get(pk=pk)
            auction.like.add(request.user)
            auction.save()

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

        try:
            comment, created = AuctionComment.objects.update_or_create(
                user=request.user, auction=self.get_object(),
                defaults={'content': content, 'price': price},
            )
            if created:
                auction = self.get_object()
                auction.count_comment = auction.count_comment + 1;
                auction.save()
        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionCommentSerializer(comment)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='fail-auction', permission_classes=[IsOwner()])
    def success_auction(self, request, pk=None):
        try:
            auction = self.get_object()
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

        try:
            state_comment = StatusAuction[kwargs.get('state')]
            if state_comment == StatusTransaction.none:
                return Response(status=status.HTTP_400_BAD_REQUEST,
                                data={"error_msg": "You only choose state auction comment: in_process, fail, success"})
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"error_msg": "Wrong state of StatusAuction"})

        auction = self.get_object()
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

        comment.save()
        auction.save()

        serializer = StatusSerializer(data={"status_auction": auction.status_auction,
                                            "status_transaction": comment.status_transaction})
        if serializer.is_valid():
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"error_msg": "Error parser response"})


class AuctionCommentAPIView(APIView):
    def get_permissions(self):
        if self.request.method == 'GET':
            return [permissions.AllowAny()]

        return [permissions.IsAuthenticated(), IsOwner()]

    def get(self, request, auction_id):
        try:
            comments = AuctionComment.objects.filter(auction__id=auction_id)
        except PostComment.DoesNotExist:
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
