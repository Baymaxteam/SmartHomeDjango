# Rest api v1 urls
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^house/$', views.House_list),
    url(r'^house/(?P<pk>[0-9]+)/$', views.House_detail),
]