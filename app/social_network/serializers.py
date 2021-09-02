from rest_framework.fields import SerializerMethodField
from rest_framework.relations import StringRelatedField
from rest_framework.serializers import ModelSerializer
from .models import *

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'avatar', 'email', 'username',
                  'phone', 'address', 'birthday', 'password']
        extra_kwargs = {
            'password': {'write_only': 'true'},
            'phone': {'read_only': 'true'},
            'avatar': {'read_only': 'true'},
            'address': {'read_only': 'true'},
        }

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
    user = UserBaseInforSerializer(read_only=True)

    class Meta:
        model = PostComment
        fields = ['id', 'content', 'user', 'vote', 'create_at']
        extra_kwargs = {
            'create_at': {'read_only': 'true'},
            'vote': {'read_only': 'true'},
        }


class PostSerializer(ModelSerializer):
    hashtag = HashTagSerializer(many=True, read_only=True)
    user = UserBaseInforSerializer(read_only=True)
    post_images = StringRelatedField(many=True, read_only=True)

    class Meta:
        model = Post
        fields = ['id', 'content', 'create_at', 'vote',
                  'hashtag', 'user', 'post_images', 'like']
        extra_kwargs = {
            'like': {'read_only': 'true'},
            'create_at': {'read_only': 'true'},
            'vote': {'read_only': 'true'},
        }


class CategorySerializer(ModelSerializer):
    class Meta:
        model = CategoryAuction
        fields = ['id', 'name']


class AuctionCommentSerializer(ModelSerializer):
    user = UserBaseInforSerializer(read_only=True)

    class Meta:
        model = AuctionComment
        fields = ['id', 'content', 'user', 'vote', 'create_at']
        extra_kwargs = {
            'create_at': {'read_only': 'true'},
            'vote': {'read_only': 'true'},
        }


class AuctionSerializer(ModelSerializer):
    category = CategorySerializer(read_only=True)
    user = UserBaseInforSerializer(read_only=True)
    auction_images = StringRelatedField(many=True, read_only=True)

    class Meta:
        model = Auction
        fields = ['id', 'content', 'create_at', 'title', 'base_price', 'condition' ,'vote', 'deadline',
                  'accept_price','status_auction', 'category', 'user', 'like', 'auction_images']
        extra_kwargs = {
            'like': {'read_only': 'true'},
            'create_at': {'read_only': 'true'},
            'status_auction': {'read_only': 'true'},
            'vote': {'read_only': 'true'},
            'accept_price': {'read_only': 'true'},
        }