from django.contrib.auth import authenticate, logout, login
from django.shortcuts import render
from rest_framework import viewsets, permissions, status, generics
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser
from .models import *
from .serializers import *
from .ultis import IsOwner


def logout_user(request):
    logout(request)


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.RetrieveAPIView, generics.UpdateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]

    def get_permissions(self):
        # if self.action == 'create':
        #     return
        # return [IsOwner()]
        return [permissions.AllowAny()]
#vấn đề chỉ ng chứng thực nào thì ms có quyền sửa thông tin đó


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

    @action(methods=['get'], detail=True, url_path='owner')
    def get_owner_post(self, request, pk=None):
        try:
            posts = Post.objects.filter(user__username=request.user.username)

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
            post.save()

        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostSerializer(post)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

def add_post():
    pass


def edit_post():
    pass


def remove_post():
    pass


def like_post():
    pass


