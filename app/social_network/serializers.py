from rest_framework.fields import SerializerMethodField
from rest_framework.relations import StringRelatedField
from rest_framework.serializers import ModelSerializer, ImageField, CharField, IntegerField, \
    FileField, ListSerializer, FloatField, Serializer
from .models import *
import re


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

    def to_representation(self, instance): #make full url to absolute url of avatar
        ret = super().to_representation(instance)
        ret['avatar'] = re.sub('''[\w\d\.:]+\/\/[\w\d\.:]+\/''', '', ret['avatar'])
        return ret

    class Meta:
        model = User
        fields = ['id', 'full_name', 'avatar']
        extra_kwargs = {
            'avatar': {'read_only': 'true'},
        }


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
    images = ImageField(allow_null=True, use_url=False, required=False, write_only=True)

    class Meta:
        model = Post
        fields = ['id', 'content', 'create_at', 'vote', 'images',
                  'hashtag', 'user', 'post_images', 'like']
        extra_kwargs = {
            'like': {'read_only': 'true'},
            'create_at': {'read_only': 'true'},
            'vote': {'read_only': 'true'},
        }


class CategoryAuctionSerializer(ModelSerializer):
    class Meta:
        model = CategoryAuction
        fields = ['id', 'name']


class AuctionImageSerializer(ModelSerializer):
    class Meta:
        model = AuctionImage
        fields = ['id', 'image']


class AuctionCommentSerializer(ModelSerializer):
    user = UserBaseInforSerializer(read_only=True)

    class Meta:
        model = AuctionComment
        fields = ['id', 'content', 'user', 'create_at', 'price', 'status_transaction']
        read_only_fields = ('create_at', 'status_transaction')


class AuctionSerializer(ModelSerializer):
    user = UserBaseInforSerializer(read_only=True)
    buyer = UserBaseInforSerializer(read_only=True)
    auction_images = SerializerMethodField(read_only=True)
    images = ImageField(allow_null=True, use_url=False, required=False, write_only=True)
    price = IntegerField(write_only=True, required=False, help_text="This only use to post comment")

    def get_auction_images(self, obj):
        return AuctionImageSerializer(obj.auction_images.all(), many=True).data

    class Meta:
        model = Auction
        fields = ['id', 'content', 'create_at', 'title', 'base_price', 'condition', 'vote', 'deadline',
                  'user', 'images', 'auction_images', 'like', 'buyer', 'date_success',
                  'accept_price', 'status_auction', 'category', 'price']
        read_only_fields = ('created_by', 'like', 'status_auction', 'vote', 'accept_price', 'date_success')
        extra_kwargs = {
            'deadline': {'required': False},
        }


class StatusSerializer(Serializer):
    status_auction = CharField(max_length=20)
    status_transaction = CharField(max_length=25)


class ReportTypeSerializer(ModelSerializer):
    class Meta:
        model = ReportType
        fields = ['id', 'name']


class PostReportSerializer(ModelSerializer):
    class Meta:
        model = PostReport
        fields = ['user', 'type', 'post', 'content', 'create_at']
        read_only_fields = ['user', 'create_at']


class AuctionReportSerializer(ModelSerializer):
    class Meta:
        model = AuctionReport
        fields = fields = ['user', 'type', 'auction', 'content', 'create_at']
        read_only_fields = ['create_at', 'user']
