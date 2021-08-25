from rest_framework.serializers import ModelSerializer
from .models import *


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
    class Meta:
        model = Post
        fields = ['id', 'content', 'create_at', 'vote', 'hashtag']


