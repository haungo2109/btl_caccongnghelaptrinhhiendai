from django.contrib.auth import authenticate, logout, login
from django.shortcuts import render
from rest_framework import viewsets, permissions, status, generics
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser
from rest_framework.views import APIView

from .models import *
from .serializers import *
from .ultis import IsOwner


def logout_user(request):
    logout(request)


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.UpdateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()]
        return [permissions.IsAuthenticated()]

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

        return [IsOwner()]

    def create(self, request):
        content = request.POST['content']
        hashtag = request.POST['hashtag']
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
            post = Post.objects.get(pk=pk)
            post.vote = post.vote + 1
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
            post.vote = post.vote - 1
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
            post = Post.objects.get(pk=pk)
            comment = PostComment.objects.create(content=content, post=post, user=request.user)

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


class AuctionViewSet(viewsets.ModelViewSet):
    queryset = Auction.objects.filter(active=True)
    serializer_class = AuctionSerializer
    parser_classes = [MultiPartParser, ]

    def get_permissions(self):
        if self.action in ['list', 'retrieve']:
            return [permissions.AllowAny()]

        return [IsOwner()]

    def create(self, request):
        content = request.POST.pop('content')
        name_category = request.POST.pop('category')
        images = request.FILES.getlist('images')

        category = CategoryAuction.objects.get_or_create(name=name_category)[0]
        auction = Auction.objects.create(content=content, user=request.user, category=category, **request.POST)

        for image in images:
            AuctionImage.objects.create(image=image, auction=auction)

        serializer = PostSerializer(auction)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['get'], detail=False, url_path='owner')
    def get_owner_post(self, request):
        try:
            auctions = Auction.objects.filter(user__id=request.user.id)

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostSerializer(auctions, many=True)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='increase-vote')
    def increase_vote(self, request, pk=None):
        try:
            auction = Auction.objects.get(pk=pk)
            auction.vote = auction.vote + 1
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
            auction.vote = auction.vote - 1
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
        try:
            auction = Auction.objects.get(pk=pk)
            comment = AuctionComment.objects.create(content=content, auction=auction, user=request.user)

        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionCommentSerializer(comment)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)


class AuctionCommentAPIView(APIView):
    def get_permissions(self):
        if self.request.method == 'GET':
            return [permissions.AllowAny()]

        return [permissions.IsAuthenticated()]

    def get(self, request, auction_id):
        try:
            comments = AuctionComment.objects.filter(auction__id=auction_id)
        except PostComment.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = AuctionCommentSerializer(comments, many=True)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)
