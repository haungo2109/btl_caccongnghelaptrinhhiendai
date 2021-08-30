from rest_framework.fields import SerializerMethodField
from rest_framework.serializers import ModelSerializer
from .models import *

class UserSerializer(ModelSerializer):
    full_name = SerializerMethodField()

    def get_full_name(self, user):
        return user.get_full_name()

    class Meta:
        model = User
        fields = ['id', 'full_name', 'avatar']


class HashTagSerializer(ModelSerializer):
    class Meta:
        model = HashTagPost
        fields = ['id', 'name']


class PostCommentSerializer(ModelSerializer):
    class Meta:
        model = PostComment
        fields = ['id', 'content']


class PostSerializer(ModelSerializer):
    hashtag = HashTagSerializer(many=True)
    user = UserSerializer()

    class Meta:
        model = Post
        fields = ['id', 'content', 'create_at', 'vote', 'hashtag', 'user']


