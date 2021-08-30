from django.contrib.auth import authenticate, logout, login
from django.shortcuts import render
from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import *
from .serializers import *

def login_user(request):
    username = request.POST['username']
    password = request.POST['password']

    user = authenticate(request,
                        username=username,
                        password=password)

    if user is not None:
        login(request, user)
    else:
        return

def logout_user(request):
    logout(request)


def register_user():
    pass


def change_password():
    user = User.objects.get(pk=2)
    user.set_password('123456')
    user.save()


def update_profile():
    pass


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.filter(active=True)
    serializer_class = PostSerializer
    # permission_classes = [permissions.IsAuthenticated]

    def get_permissions(self):
        if self.action in ['list', 'retrieve']:
            return [permissions.AllowAny()]

        return [permissions.IsAuthenticated()]

    def create(self, request):
        content = request.POST['content']
        hashtag = request.POST['hashtag']

        if hashtag:
            hashtag = HashTagPost.objects.create(name=hashtag)

        post = Post.objects.create(content=content, hashtag=hash)
        serializer = PostSerializer(post)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['get'], detail=True, url_path='increase-vote')
    def increase_vote(self, request, pk=None):
        try:
            post = Post.objects.get(pk=pk)
            post.vote = post.vote + 1
            post.save()

        except Post.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        serializer = PostSerializer(post)
        return Response(serializer.data,
                        status=status.HTTP_200_OK)

    @action(methods=['get'], detail=True, url_path='decrease-vote')
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


