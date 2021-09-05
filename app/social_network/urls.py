from django.urls import path, include
from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
router.register('post', views.PostViewSet)
router.register('user', views.UserViewSet)
router.register('auction', views.AuctionViewSet, basename='auction')
router.register('category', views.CategoryViewSet)
router.register('report-type', views.ReportTypeViewSet)
router.register('post-report', views.PostReportViewSet, basename='post-report')
router.register('auction-report', views.AuctionReportViewSet, basename='auction-report')


urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin_site.urls),
    path('post-comments/<int:post_id>/',  views.PostCommentAPIView.as_view()),
    path('auction-comments/<int:auction_id>/',  views.AuctionCommentAPIView.as_view()),
]

