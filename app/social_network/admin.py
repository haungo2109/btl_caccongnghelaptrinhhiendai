from django.contrib import admin
from django.contrib.auth.models import Permission, Group
from django.db.models import Count
from django.template.response import TemplateResponse
from django.utils.html import mark_safe
from django.urls import path
from django.forms import ModelForm

from .models import User, Post, Auction, AuctionComment, PostComment, AuctionImage, PostImage, PostReport, \
    AuctionReport, HashTagPost, CategoryAuction, ReportType, PaymentMethod


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

    def get_urls(self):
        return [
                   path('report/', self.stats_view)
               ] + super().get_urls()

    def stats_view(self, request):
        count = Post.objects.filter(active=True).count()
        return TemplateResponse(request,
                                'admin/report.html', {
                                    'count': count,
                                    'title': "Post report"
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