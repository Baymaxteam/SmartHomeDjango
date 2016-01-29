from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser

from .models import House, Nodes, NodeState, CurrentState, IRcommend
from .serializers import HouseSerializer, NodesSerializer, NodeslistSerializer, NodesCommendSerializer

class JSONResponse(HttpResponse):
	# """
	# An HttpResponse that renders its content into JSON.
	# """
	def __init__(self, data, **kwargs):
		content = JSONRenderer().render(data)
		kwargs['content_type'] = 'application/json'
		super(JSONResponse, self).__init__(content, **kwargs)

@csrf_exempt
def House_list(request):
	if request.method == 'GET':
		HouseSetting = House.objects.all()
		serializer = HouseSerializer(HouseSetting, many=True)
		return JSONResponse(serializer.data)

	elif request.method == 'POST':
		data = JSONParser().parse(request)
		ID = data['GroupID'] # 檢查ID是否有重複
		# Create_or_update 
		try:
			house = House.objects.get(GroupID = ID)
			serializer = HouseSerializer(house, data=data) # update
		except House.DoesNotExist:
			serializer = HouseSerializer(data=data) # creat
		if serializer.is_valid():
			serializer.save()
			return HttpResponse(status=204)
		return JSONResponse(serializer.errors, status=400)

		
@csrf_exempt
def House_detail(request, GroupID):
	try:
		house = House.objects.get(GroupID = GroupID)
	except House.DoesNotExist:
		return HttpResponse(status=404)

	if request.method == 'GET':
		serializer = HouseSerializer(house)
		return JSONResponse(serializer.data)

	elif request.method == 'PUT':
		data = JSONParser().parse(request)
		serializer = HouseSerializer(house, data=data)
		if serializer.is_valid():
			serializer.save()
			return JSONResponse(serializer.data)
		return JSONResponse(serializer.errors, status=400)

	elif request.method == 'DELETE':
		house.delete()
		return HttpResponse(status=204)


# Node_list
# Get:表列所有Node, 耗電量, 所屬Group, State 
@csrf_exempt
def Node_list(request):
	if request.method == 'GET':
		Nodelist = Nodes.objects.all()
		serializer = NodeslistSerializer(Nodelist, many=True)
		return JSONResponse(serializer.data)

# Node_detail
# Get:表列特定Node的詳細資料(Address, ID, ...) 歷史耗電量(1Week), 歷史State(1week) 
# PUT:改變NodeState，命令開關或是轉台調溫度
@csrf_exempt
def Node_detail(request, NodeID): 
	try:
		node = Nodes.objects.get(NodeID = NodeID)
	except Node.DoesNotExist:
		return HttpResponse(status=404)

	if request.method == 'GET':
		serializer = NodesSerializer(node)
		return JSONResponse(serializer.data)

	elif request.method == 'PUT':
		# 這裡要插入控制Node的Code
		# 記得發送完控制訊號要寫入資料庫NodeState
		data = JSONParser().parse(request)
		serializer = NodesCommendSerializer(node, data=data)
		if serializer.is_valid():
			serializer.save()
			return JSONResponse(serializer.data)
		return JSONResponse(serializer.errors, status=400)
		



