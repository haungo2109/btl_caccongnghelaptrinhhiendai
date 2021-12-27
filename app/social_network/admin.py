import json

from django.contrib import admin
from django.contrib.auth.models import Permission, Group
from django.db.models import Count
from django.db.models.functions import Coalesce, TruncMonth, TruncYear, ExtractMonth
from django.template.response import TemplateResponse
from django.utils.html import mark_safe
from django.urls import path
from django.forms import ModelForm
from django.db.models import Avg

from .models import User, Post, Auction, AuctionComment, PostComment, AuctionImage, PostImage, PostReport, \
    AuctionReport, HashTagPost, CategoryAuction, ReportType, PaymentMethod, StatusAuction
from .ultis import group_by_month


class UserAdmin(admin.ModelAdmin):
    list_display = ['id', 'first_name', 'last_name', 'phone', 'username']
    search_fields = ['phone', 'email', 'first_name', 'last_name']
    readonly_fields = ['image']

    def image(self, user):
        if user:
            return mark_safe(
                "<img src='/static/{url}' width='150' alt='avatar' />"\
                .format(url=user.avatar)
            )


class PostCommentAdmin(admin.StackedInline):
    model = PostComment
    pk_name = 'post'


class PostImageInline(admin.StackedInline):
    model = PostImage
    pk_name = 'post'
    readonly_fields = ['image_post']

    def image_post(self, postimage):
        if postimage:
            return mark_safe(
                "<img src='/static/{url}' width='150' alt='avatar' />" \
                    .format(url=postimage.image)
            )


class PostAdmin(admin.ModelAdmin):
    inlines = (PostImageInline, PostCommentAdmin, )
    list_display = ['id', 'content', 'count_comment', 'create_at', 'user', ]
    search_fields = ['content', 'user__first_name', 'user__last_name']


class AuctionCommentAdmin(admin.StackedInline):
    model = AuctionComment
    pk_name = 'post'


class AuctionImageInline(admin.StackedInline):
    model = AuctionImage
    pk_name = 'post'
    readonly_fields = ['image_auction']

    def image_auction(self, auction_image):
        if auction_image:
            return mark_safe(
                "<img src='/static/{url}' width='150' alt='avatar' />" \
                    .format(url=auction_image.image)
            )


class AuctionForm(ModelForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['date_success'].required = False
        self.fields['accept_price'].required = False
        self.fields['buyer'].required = False

    class Meta:
        model = Auction
        fields = '__all__'


class AuctionAdmin(admin.ModelAdmin):
    form = AuctionForm
    inlines = (AuctionImageInline,AuctionCommentAdmin)
    list_display = ['id', 'title', 'count_comment', 'create_at', 'base_price', "payment_method", 'user']
    search_fields = ['title', 'user__first_name', 'user__last_name']


class HashTagPostAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class PaymentMethodAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class CategoryAuctionAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class ReportTypeAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class PostReportAdmin(admin.ModelAdmin):
    list_display = ['id', 'content', 'type', 'user', 'post']


class AuctionReportAdmin(admin.ModelAdmin):
    list_display = ['id', 'content', 'type', 'user', 'auction']


class SocialNetworkAdminSite(admin.AdminSite):
    site_header = 'SOCIAL NETWORK ABOUT AUCTION'
    months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October',
              'November', 'December']
    def get_urls(self):
        return [
                   path('report/', self.overview),
                   path('report-auction/', self.reportAuction),
                   path('report-post/', self.reportPost)
               ] + super().get_urls()

    def overview(self, request):
        count_post = Post.objects.filter(active=True).count()
        post_like = Post.objects.filter(active=True).annotate(count=Count('like')).aggregate(avg=Avg('count'))
        post_comment = Post.objects.filter(active=True).aggregate(Avg('count_comment'))

        count_auction = Auction.objects.filter(active=True).count()
        count_auction_succ = Auction.objects.filter(active=True, status_auction=StatusAuction.success).count()
        count_auction_fail = Auction.objects.filter(active=True, status_auction=StatusAuction.fail).count()
        categorys = CategoryAuction.objects.annotate(count=Count('auctions__id')).order_by('count')
        rs = []
        for cate in categorys:
            rs.append(cate.name + "(" + str(cate.count) + ")")
        return TemplateResponse(request,
                                'admin/report.html', {
                                    'count_post': count_post,
                                    'count_post_like_avg': int(post_like.get("avg")),
                                    'count_post_comment_avg': int(post_comment.get("count_comment__avg")),
                                    'count_auction': count_auction,
                                    'count_auction_succ': count_auction_succ,
                                    'count_auction_fail': count_auction_fail,
                                    'order_auction_by_category': (', ').join(rs)
                                })
    def reportAuction(self, request):
        categorys = CategoryAuction.objects.annotate(count=Count('auctions__id')).order_by('count')
        auction_by_time = Auction.objects.filter(create_at__year=2021).annotate(month=ExtractMonth('create_at'))\
            .values('month').annotate(count=Count('id')).values('month', 'count')

        d = group_by_month(self.months, auction_by_time)
        return TemplateResponse(request,
                                'admin/report-auction.html', ({
                                    'label_cates': ",".join([i.name for i in categorys]),
                                    'data_cates': [i.count for i in categorys],
                                    'label_month': ','.join(d.keys()),
                                    'data_month': list(d.values()),
                                }))

    def reportPost(self, request):
        post_by_time = Post.objects.filter(create_at__year=2021).annotate(month=ExtractMonth('create_at')) \
            .values('month').annotate(count=Count('id')).values('month', 'count')
        d = group_by_month(self.months, post_by_time)

        return TemplateResponse(request,
                                'admin/report-post.html', {
                                    'label_month': ','.join(d.keys()),
                                    'data_month': list(d.values()),
                                })


admin_site = SocialNetworkAdminSite('app')

admin_site.register(Group)
admin_site.register(Permission)
admin_site.register(User, UserAdmin)

admin_site.register(CategoryAuction, CategoryAuctionAdmin)
admin_site.register(ReportType, ReportTypeAdmin)
admin_site.register(HashTagPost, HashTagPostAdmin)
admin_site.register(PaymentMethod, PaymentMethodAdmin)

admin_site.register(Post, PostAdmin)
admin_site.register(Auction, AuctionAdmin)

admin_site.register(PostReport, PostReportAdmin)
admin_site.register(AuctionReport, AuctionReportAdmin)