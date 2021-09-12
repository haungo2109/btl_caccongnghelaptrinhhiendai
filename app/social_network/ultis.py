from rest_framework import permissions
from rest_framework.pagination import PageNumberPagination


def user_directory_path(instance, filename):
    # file will be uploaded to MEDIA_ROOT/user_<id>/<filename>
    return 'static/avatar/user_{0}/{1}'.format(instance.username, filename)


class IsOwner(permissions.BasePermission):
    """
    Object-level permission to only allow owners of an object to edit it.
    Assumes the model instance has an `owner` attribute.
    """
    message = "You're not an onwer of this resource."

    def has_object_permission(self, request, view, obj):
        if request.user.is_authenticated:
            return obj.user.username == request.user.username
        else:
            False


class IsCurrentUser(permissions.BasePermission):
    message = "You're not an onwer of this resource."

    def has_object_permission(self, request, view, obj):
        if request.user.is_authenticated:
            return obj.username == request.user.username
        else:
            False


class StandardResultsSetPagination(PageNumberPagination):
    page_size = 100
    page_size_query_param = 'page_size'
    max_page_size = 1000