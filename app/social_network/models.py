from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
from django.db import models


class User(AbstractUser):
    phone = models.CharField(max_length=11, unique=True)
    avatar = models.ImageField(upload_to='upload/%Y/%m', default=None)
    address = models.CharField(max_length=255)
    birthday = models.DateField()
    
    def __str__(self):
        return self.name


class BaseInfo(models.Model):
    content = models.TextField(blank=True, null=True)
    create_at = models.DateTimeField(auto_now_add=True, null=True)

    class Meta:
        abstract = True
        ordering=['create_at']

    def __str__(self):
        return self.content


class Report(BaseInfo):
    type = models.CharField(max_length=255)
    user = models.ForeignKey('User', on_delete=models.SET_NULL, null=True, related_name='reposts')
    post = models.ForeignKey('Post', on_delete=models.SET_NULL, null=True, related_name='reposts')


class CommentPost(BaseInfo):
    vote = models.IntegerField(default=0)
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    post = models.ForeignKey('Post', on_delete=models.CASCADE, related_name='post_comments')


class Post(BaseInfo):
    vote = models.IntegerField(default=0)
    image = models.CharField(max_length=255)
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='posts')


class Auction(Post):
    class StatusAuction(models.TextChoices):
        success = 'succ', _('Sản phẩm đã được giao dịch thành công')
        fail = 'fail', _('Dấu giá sản phẩm đã bị hủy')
        auction = 'being auctioned', _('Sản phẩm đang được đấu giá')
        in_process = 'in process', _('Sản phẩm trang trong quá trinfg chuyển giao đấu giá')


    base_price = models.FloatField(default=0)
    condition = models.CharField(max_length=1000, default=None)
    deadline = models.DateTimeField()
    accept_price = models.FloatField(null=True)
    status_auction = models.CharField(max_length=20, choices=StatusAuction.choices, default=StatusAuction.in_process)


class CommentAuction(BaseInfo):
    class StatusTransaction(models.TextChoices):
        success = 'succ', _('Giao dịch thành công')
        fail = 'fail', _('Giao dịch đã bị hủy')
        in_process = 'in process', _('Hai bên đag giao dịch')
        none = 'none', _('Chưa giao dịch')

    price = models.FloatField()
    user = models.ForeignKey('User', on_delete=models.SET_NULL, null=True)
    auction = models.ForeignKey('Auction', related_name='auction_comments', on_delete=models.CASCADE, default='anonymous')
    status_transaction = models.CharField(max_length=11, choices=StatusTransaction.choices, default=StatusTransaction.none)

    class Meta:
        ordering = ['create_at', 'price']

    def __str__(self):
        return self.description

class PostImage(models.Model):
    image = models.CharField(max_length=100)
    post = models.ForeignKey('Post', on_delete=models.CASCADE, related_name='post_images')


class AuctionImage(models.Model):
    image = models.CharField(max_length=100)
    auction = models.ForeignKey('Auction', on_delete=models.CASCADE, related_name='auction_images')