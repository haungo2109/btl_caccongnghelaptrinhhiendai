from django.contrib.auth import authenticate, logout, login
from django.shortcuts import render
from rest_framework import viewsets, permissions
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
        if self.action == 'list':
            return [permissions.AllowAny()]

        return [permissions.IsAuthenticated()]


def post_all():
    pass


def post_of_user():
    pass


def add_post():
    pass


def edit_post():
    pass


def remove_post():
    pass


def like_post():
    pass


# post all 5 item
# post of user
# add post
# edit post
# remove post
# like
# unlike
# comment
# update avatar
# update background
# update information
# update password
