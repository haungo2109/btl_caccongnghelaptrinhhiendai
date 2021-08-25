from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
from django.db import models

from .ultis import user_directory_path


class User(AbstractUser):
    phone = models.CharField(max_length=11, unique=True, null=True)
    avatar = models.ImageField(upload_to=user_directory_path, default=None, null=True)
    address = models.CharField(max_length=255, null=True)
    birthday = models.DateField(null=True)
    
    def __str__(self):
        return self.get_full_name()


class CategoryAuction(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class HashTagPost(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class BaseInfo(models.Model):
    content = models.TextField(blank=True, null=True)
    create_at = models.DateTimeField(auto_now_add=True, null=True)

    class Meta:
        abstract = True
        ordering=['create_at']

    def __str__(self):
        if self.content:
            return self.content
        else:
            return "Null content";


class Post(BaseInfo):
    vote = models.IntegerField(default=0)
    active = models.BooleanField(default=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='posts')
    hashtag = models.ManyToManyField(HashTagPost, related_name='hashtag_posts', blank=True)


class Auction(BaseInfo):
    class StatusAuction(models.TextChoices):
        success = 'succ', _('Sản phẩm đã được giao dịch thành công')
        fail = 'fail', _('Dấu giá sản phẩm đã bị hủy')
        auction = 'being auctioned', _('Sản phẩm đang được đấu giá')
        in_process = 'in process', _('Sản phẩm trang trong quá trình chuyển giao khách hàng')

    title = models.CharField(max_length=225, default='Auction')
    active = models.BooleanField(default=True)
    vote = models.IntegerField(default=0)
    base_price = models.FloatField(default=0)
    condition = models.TextField(blank=True, null=True, default="No condition")
    deadline = models.DateTimeField()
    accept_price = models.FloatField(null=True, default=0)
    status_auction = models.CharField(max_length=20, choices=StatusAuction.choices, default=StatusAuction.auction)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='auctions')
    category = models.ForeignKey(CategoryAuction, on_delete=models.SET_NULL, null=True)

class PostComment(BaseInfo):
    vote = models.IntegerField(default=0)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='post_comments')


class AuctionComment(BaseInfo):
    class StatusTransaction(models.TextChoices):
        success = 'succ', _('Giao dịch thành công')
        fail = 'fail', _('Giao dịch đã bị hủy')
        in_process = 'in process', _('Hai bên đag giao dịch')
        none = 'none', _('Chưa giao dịch')

    price = models.FloatField()
    status_transaction = models.CharField(max_length=11, choices=StatusTransaction.choices, default=StatusTransaction.none)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    auction = models.ForeignKey(Auction, related_name='auction_comments', on_delete=models.CASCADE, default='anonymous')

    class Meta:
        ordering = ['create_at', 'price']

class PostImage(models.Model):
    image = models.ImageField(upload_to='post_images/%Y/%m', default=None, null=True)
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='post_images')


class AuctionImage(models.Model):
    image = models.ImageField(upload_to='auction_images/%Y/%m', default=None, null=True)
    auction = models.ForeignKey(Auction, on_delete=models.CASCADE, related_name='auction_images')


class PostReport(BaseInfo):
    type = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    post = models.ForeignKey(Post, on_delete=models.SET_NULL, null=True, related_name='post_reports')


class AuctionReport(BaseInfo):
    type = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    auction = models.ForeignKey(Auction, on_delete=models.SET_NULL, null=True, related_name='auction_reports')