import datetime
import pytz
from django.utils.dateparse import parse_datetime
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser

from .models import House, Nodes, NodeState, CurrentState, IRcommend, TaskSchedule
from .serializers import HouseSerializer, NodesSerializer, NodeslistSerializer, TaskslistSerializer
from SmartHome.node.tasks import node_N_all_open, node_N_all_close, PeriodicTest


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
	return HttpResponse(status=404)

		
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
	return HttpResponse(status=404)



# Node_list
# Get:表列所有Node, 耗電量, 所屬Group, State 
@csrf_exempt
def Node_list(request):
	if request.method == 'GET':
		Nodelist = Nodes.objects.all()
		serializer = NodeslistSerializer(Nodelist, many=True)
		return JSONResponse(serializer.data)
	return HttpResponse(status=404)

# Node_detail
# Get:表列特定Node的詳細資料(Address, ID, ...) 歷史耗電量(1Week), 歷史State(1week) 
# PUT:改變NodeState，命令開關或是轉台調溫度
@csrf_exempt
def Node_detail(request, NodeID): 
	try:
		node_obj = Nodes.objects.get(ID = NodeID)
	except Nodes.DoesNotExist:
		return HttpResponse(status=404)

	if request.method == 'GET':
		serializer = NodesSerializer(node_obj)
		return JSONResponse(serializer.data)

	elif request.method == 'PUT':
		# 這裡要插入控制Node的Code
		# 記得發送完控制訊號要寫入資料庫NodeState
		
		data = JSONParser().parse(request)

		data['NodeID'] = NodeID
		commd = data['State']
		# 檢查commd是node可接受命令
		vailded = False
		nodeType = node_obj.Type
		if nodeType == 'N': 
			if commd in [0, 1]:
				vailded = True
		elif nodeType == 'L':
			if commd in range(8):
				vailded = True
		elif nodeType == 'IR':
			vailded = True
		else:
			return HttpResponse(status=500)
		#-----------------------------#		
		## 檢查通過則下命令給node!!!
		#-----------------------------#
		if vailded: 
			NodeState.objects.create(NodeID = node_obj, State = commd, Added = datetime.datetime.now())
			msg = 'Node '+str(NodeID)+' state seting to '+ str(data['State'])
			if data['State'] ==1 :
				#PeriodicTest.apply_async((15,), countdown=15)
				node_N_all_open.apply_async()
			elif data['State'] ==0:
				node_N_all_close.apply_async()
			
			print(msg)

			return JSONResponse(data)
		return JSONResponse(data, status=400)

	return HttpResponse(status=404)
		
@csrf_exempt
def schedule_list(request):
	if request.method == 'GET':
		Tasks = TaskSchedule.objects.all()
		serializer = TaskslistSerializer(Tasks, many=True)
		data  = serializer.data
		#data['NodeID'] = data['NodeID']['ID']
		return JSONResponse(data)
	return HttpResponse(status=404)

@csrf_exempt
def schedule_detail(request, NodeID):
	try:
		node_obj = Nodes.objects.get(ID = NodeID)
	except Nodes.DoesNotExist:
		return HttpResponse(status=404)
	if request.method == 'PUT':
		data = JSONParser().parse(request)
		# Example : {"triggerTime": "2016-01-19T08:38:15.653108Z" , "State":0}
		triggerTime = parse_datetime(data['triggerTime'])
		triggerTime = pytz.timezone("Asia/Taipei").localize(triggerTime, is_dst=None)
		commd = data['State']
		completed = False
		queued = True
		TaskSchedule.objects.create(NodeID = node_obj, triggerTime = triggerTime, Commend= commd, completed=completed, queued = queued)

		return JSONResponse(data)



	# elif request.method == 'DELETE':
	# 	house.delete()
	# 	return HttpResponse(status=204)
	# return HttpResponse(status=404)


