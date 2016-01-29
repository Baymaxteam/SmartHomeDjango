# Rest api v1 urls
from django.conf.urls import url
from . import views

urlpatterns = [
    # Get:表列Group POST:新增Group
    url(r'V1/house/$', views.House_list),
    # Get:詳列Group的 Node,耗電量, NodeState PUT: 更新Group Name DELETE:刪除Group
    url(r'V1/house/(?P<GroupID>\w+)/$', views.House_detail),
    # Get:表列所有Node, 耗電量, 所屬Group, State 
    url(r'V1/node/$', views.Node_list),
   	# Get:表列特定Node的詳細資料(Address, ID, ...) 歷史耗電量(1Week), 歷史State(1week) 
   	# PUT:改變NodeState，命令開關或是轉台調溫度
    url(r'V1/node/(?P<NodeID>[0-9]+)/$', views.Node_detail),
    # schedule_list
    # url(r'^/V1/schedule/$', views.schedule_list),
]