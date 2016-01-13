# Rest api v1 urls
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^house/$', views.House_list),
    url(r'^house/(?P<GroupID>\w+)/$', views.House_detail),
]