from rest_framework.fields import SerializerMethodField
from rest_framework.relations import StringRelatedField
from rest_framework.serializers import ModelSerializer, ImageField, CharField, IntegerField, \
    FileField, ListSerializer, FloatField
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

    class Meta:
        model = Post
        fields = ['id', 'content', 'create_at', 'vote',
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
    # content = CharField(write_only=True, required=True)
    # price = FloatField(write_only=True, required=True)

    class Meta:
        model = AuctionComment
        fields = ['id', 'content', 'user', 'create_at', 'price', 'status_transaction']
        read_only_fields = ('create_at', 'status_transaction')
        # extra_kwargs = {
        #     'content': {'required': True},
        #     'price': {'required': True},
        # }

class AuctionSerializer(ModelSerializer):
    user = UserBaseInforSerializer(read_only=True)
    auction_images = SerializerMethodField(read_only=True)
    images = ImageField(allow_null=True, use_url=False, required=False, write_only=True)

    def get_auction_images(self, obj):
        return AuctionImageSerializer(obj.auction_images.all(), many=True).data

    class Meta:
        model = Auction
        fields = ['id', 'content', 'create_at', 'title', 'base_price', 'condition', 'vote', 'deadline',
                  'user', 'images', 'auction_images', 'like',
                  'accept_price', 'status_auction', 'category', ]
        read_only_fields = ('created_by', 'like', 'status_auction', 'vote', 'accept_price')
        extra_kwargs = {
            'deadline': {'required': False},
        }
