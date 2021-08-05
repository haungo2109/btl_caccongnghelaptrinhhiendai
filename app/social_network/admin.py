from django.contrib import admin
from django.utils.html import mark_safe

from .models import User, Post, Auction, AuctionComment, PostComment, AuctionImage, PostImage, PostReport, AuctionReport


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
    inlines = (PostImageInline,PostCommentAdmin)
    list_display = ['content', 'vote', 'create_at', 'user']
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

class AuctionAdmin(admin.ModelAdmin):
    inlines = (AuctionImageInline,AuctionCommentAdmin)
    list_display = ['title', 'vote', 'create_at', 'base_price', 'user']
    search_fields = ['title', 'user__first_name', 'user__last_name']


admin.site.register(User, UserAdmin)
admin.site.register(Post, PostAdmin)
admin.site.register(Auction, AuctionAdmin)
admin.site.register(PostReport)
admin.site.register(AuctionReport)
