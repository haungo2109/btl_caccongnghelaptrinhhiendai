from django.urls import path, include
from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
router.register('post', views.PostViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin_site.urls),
    path('o/', include('oauth2_provider.urls', namespace='oauth2_provider')),
]

