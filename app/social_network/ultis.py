from oauth2_provider.settings import oauth2_settings
from rest_framework import permissions
from rest_framework.pagination import PageNumberPagination
from exponent_server_sdk import (
    DeviceNotRegisteredError,
    PushClient,
    PushMessage,
    PushServerError,
    PushTicketError,
)

from requests.exceptions import ConnectionError, HTTPError
from .models import *
import rsa
import json
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_v1_5 as Cipher_PKCS1_v1_5
from base64 import b64encode
import json
import requests
import uuid
import hmac
import hashlib
from oauth2_provider.models import Application, AccessToken, RefreshToken
from time import timezone
from datetime import timedelta, datetime
from oauthlib import common

client_id = "TPLrxQE8mF9slRzevZSNbNCLQXDSSbJrnIprMCNM"
endpoint = "https://test-payment.momo.vn/pay/app"
public_key = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApn2o3p2ww8Yda6sEgn/IcXVSJR65jxF78uoYVLoejsE+cJVqI5mXla/PVj5vqJ0mfjTS4QPIj8ENSwLlMNUnsr++bvp1G3VlRtdyIjHjMMQoerE7mBnYvvGiLHccwngPi+Wn/h6HLrtj/a4DAl1WR87K4XbCS3MfGJJiPJHB9qQy/g0JBbELPenF5dV45uIcxJ2CUBR0wGabhf3Fr2xDm8K7u+OCwMJFWHJx066sPfo2eSY+PFnZjl6wk0QrL2A35hnqRrDc+KIlCxvnxNcc9fpEm9veyLjMVNQvA0ce4BdOnycgHdHjA4TWoIZ93oeFFIjISDnRm4rrBFGGsVlNCGrw8byvRMoDMESLLAlodUmMTlzGQ8EHV5emcOOWWi4Sa3Vy1qA9SkC36A2umpVZLbADLKcTrrz3gcBYzIPz2jhv2NvFltamdBiiSgv6NTGeX8g7DY+vmzXCFgjLUNV53EnIgwq8IvGDKxHZIO/yxo2MwnlsPAQuclRM5ie3nLCET3COwj9TN4lt+c287hl1gGw3TYEKOW+sLS+Q/OVah+wyoNHMPjlNRb4cZZf5S3wfnelq0/K9Uu9C1iVSV6W7j462+iVQer3mgKsA3gbydLgTz38LMB2lA8LOLallVK5OHtohXpOJt5P5JkXhmH5pL07vT59UcSxTrxqXILIBVx8CAwEAAQ=="
base_path = "/home/kan_haungo/Desktop/btl_caccongnghelaptrinhhiendai/app/social_network"

def send_push_message(token, title, message, extra=None):
    try:
        response = PushClient().publish(
            PushMessage(to=token,
                        title=title,
                        body=message,
                        data=extra))
    except PushServerError as exc:
        print(exc)
    except (ConnectionError, HTTPError) as exc:
        print(exc)

    try:
        response.validate_response()
    except DeviceNotRegisteredError as ex:
        print("error", ex)
        # User.objects.filter(push_token=token).update(push_token="none")
    except PushTicketError as exc:
        print(exc)


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


#this function user capercase to fit with request of Momo
def create_hash_by_RSA(rowData={}):
    amount = rowData.get('amount')
    partnerRefId = rowData.get('partnerRefId')
    partnerCode = rowData.get('partnerCode')

    if not (amount and partnerCode and partnerRefId):
        return

    f = open(base_path + '/mykey.pem', 'r')
    key = RSA.importKey(f.read())

    cipher = Cipher_PKCS1_v1_5.new(key)
    cipher_text = cipher.encrypt(json.dumps(rowData).encode())
    return b64encode(cipher_text)


def send_request_to_momo(data):
    data_string = json.dumps(data)
    r = requests.post(url=endpoint, data=data_string, headers={"Content-Type": "application/json"})
    res = r.json()

    return res

def validate_token_login_by_gg(token):
    url = "https://oauth2.googleapis.com/tokeninfo?access_token=%s" % token
    res = requests.post(url=url)
    data = res.json()
    return data

def create_access_token_with_user(user):
    application = Application.objects.get(client_id=client_id)
    expires = datetime.now() + timedelta(seconds=36000)
    access_token = AccessToken(
        user=user,
        scope='read write',
        expires=expires,
        token=common.generate_token(30),
        application=application
    )
    access_token.save()
    refresh_token = RefreshToken(
        user=user,
        token=common.generate_token(30),
        application=application,
        access_token=access_token
    )
    refresh_token.save()

    return {
        "access_token": access_token.token,
        "expires_in": 36000,
        "token_type": "Bearer",
        "scope": "read write",
        "refresh_token": refresh_token.token
    }