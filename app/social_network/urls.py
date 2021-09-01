from django.urls import path, include
from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
router.register('post', views.PostViewSet)
router.register('user', views.UserViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin_site.urls),

]

