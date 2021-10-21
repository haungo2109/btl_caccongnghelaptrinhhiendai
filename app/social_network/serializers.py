from rest_framework.fields import SerializerMethodField
from rest_framework.relations import StringRelatedField, PrimaryKeyRelatedField
from rest_framework.serializers import ModelSerializer, ImageField, CharField, IntegerField, \
    FileField, JSONField, FloatField, Serializer, DateTimeField, ChoiceField
from .models import *
import re


class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'avatar', 'email', 'username',
                  'phone', 'address', 'birthday', 'password', 'push_token']
        extra_kwargs = {
            'password': {'write_only': 'true'},
            'address': {'required': False},
            'birthday': {'required': False},
            'phone': {'required': False},
            'push_token': {'required': False},
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
        if re.search('''[\w\d\.:]+\/\/[\w\d\.:]+\/''', ret['avatar']):
            ret['avatar'] = "/" + re.sub('''[\w\d\.:]+\/\/[\w\d\.:]+\/''', '', ret['avatar'])
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
        fields = ['id', 'content', 'user', 'create_at']
        extra_kwargs = {
            'create_at': {'read_only': 'true'},
        }


class PostSerializer(ModelSerializer):
    hashtag = HashTagSerializer(many=True, read_only=True)
    user = UserBaseInforSerializer(read_only=True)
    post_images = StringRelatedField(many=True, read_only=True)
    images = ImageField(allow_null=True, use_url=False, required=False, write_only=True)

    class Meta:
        model = Post
        fields = ['id', 'content', 'create_at', 'count_comment', 'images',
                  'hashtag', 'user', 'post_images', 'like']
        extra_kwargs = {
            'like': {'read_only': 'true'},
            'create_at': {'read_only': 'true'},
            'count_comment': {'read_only': 'true'},
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


class PaymentMethodSerializer(ModelSerializer):
    class Meta:
        model = PaymentMethod
        fields = ['id', 'name']


class AuctionSerializer(ModelSerializer):
    user = UserBaseInforSerializer(read_only=True)
    buyer = UserBaseInforSerializer(read_only=True)
    auction_images = StringRelatedField(many=True, read_only=True)
    images = ImageField(allow_null=True, use_url=False, required=False, write_only=True)
    price = IntegerField(write_only=True, required=False, help_text="This only use to post comment")

    class Meta:
        model = Auction
        fields = ['id', 'content', 'create_at', 'title', 'base_price', 'condition', 'count_comment', 'deadline',
                  'user', 'images', 'auction_images', 'like', 'buyer', 'date_success',
                  'accept_price', 'status_auction', 'category', 'price', 'payment_method']
        read_only_fields = ('created_by', 'like', 'status_auction', 'count_comment',
                            'accept_price', 'date_success')
        extra_kwargs = {
            'deadline': {'required': False},
        }


class StatusSerializer(Serializer):
    status_auction = CharField(max_length=20)
    status_transaction = CharField(max_length=25)
    auction_id= CharField(max_length=20)
    comment_id = CharField(max_length=20)
    date_success = DateTimeField(allow_null=True)
    accept_price = FloatField(allow_null=True)
    buyer = JSONField(allow_null=True)


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

class MomoPaySerializer(Serializer):
    auction_id = CharField(max_length=30)
    date_success = DateTimeField()
    accept_price = FloatField()
    buyer = JSONField(allow_null=True)
    status_auction = ChoiceField(choices=StatusAuction.choices)

    status_transaction = ChoiceField(choices=StatusTransaction.choices)
    comment_id = CharField(max_length=50)

    message = CharField(max_length=100)


class FeedbackSerializer(ModelSerializer):
    class Meta:
        model = Feedback
        fields = ['content', "title", "create_at"]

        read_only_fields = ["create_at"]