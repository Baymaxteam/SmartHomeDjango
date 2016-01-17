# Rest api v1 urls
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^/V1/house/$', views.House_list),
    url(r'^/V1/house/(?P<GroupID>\w+)/$', views.House_detail),
    url(r'^/V1/node/$', views.Node_list),
    url(r'^/V1/node/(?P<NodeID>[0-9]+)/$', views.Node_detail),
]