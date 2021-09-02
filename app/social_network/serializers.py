from rest_framework.fields import SerializerMethodField
from rest_framework.relations import StringRelatedField, SlugRelatedField, HyperlinkedIdentityField
from rest_framework.serializers import ModelSerializer
from rest_framework.response import Response
from rest_framework import status
from .models import *

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'avatar', 'email', 'username',
                  'phone', 'address', 'birthday', 'password']
        extra_kwargs = {
            'password': {'write_only': 'true'},
            'phone': {'read_only': 'true'},
            'birthday': {'read_only': 'true'},
        }
        # mấy cột t igrore thì khỏi cần phaair đưa lên, vd như thêm avatar nữa , tạo tk rồi ng ta cập nhật sau
    #     sau khi đăng nhập không gửi về token ?, đk không gửi về token, đăng nhập ms gửi, có token rồi ms lấy được thông tin user


    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()

        return user


class UserBaseInforSerializer(ModelSerializer):
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


class PostImageSerializer(ModelSerializer):
    class Meta:
        model = PostImage
        fileds = ['image', 'id']


class PostSerializer(ModelSerializer):
    hashtag = HashTagSerializer(many=True, read_only=True)
    user = UserBaseInforSerializer(read_only=True)
    # post_images = StringRelatedField(many=True, read_only=True)

    class Meta:
        model = Post
        fields = ['id', 'content', 'create_at', 'vote',
                  'hashtag', 'user', 'post_images', 'like']

        extra_kwargs = {
            'like': {'read_only': 'true'},
            'create_at': {'read_only': 'true'},
            'vote': {'read_only': 'true'},
        }
