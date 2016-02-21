import datetime
import pytz
from django.utils.dateparse import parse_datetime
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser

from .models import House, Nodes, NodeState, CurrentState, IRcommend, TaskSchedule
from .serializers import HouseSerializer, NodesSerializer, NodeslistSerializer, TaskslistSerializer, CurrentStateSerializer
from SmartHome.node.tasks import *


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
		#-----------------------------#		
		## 檢查通過則下命令給node!!!
		#-----------------------------#
		if nodeType == 'N': 
			if commd in [0, 1]:
				vailded = True
				node_N_one_turn.apply_async((commd, node_obj.Address,))
		elif nodeType == 'L':
			if commd in range(8):
				vailded = True
				node_L_one_turn.apply_async((commd, node_obj.Address))
		elif nodeType == 'IR':
			vailded = True
			IR_node_send.apply_async((commd, ))
		else:
			return HttpResponse(status=500)
		#-----------------------------#		
		## 檢查通過則寫入資料庫
		#-----------------------------#
		if vailded: 
			addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
			NodeState.objects.create(NodeID = node_obj, State = commd, Added = addedtime)
			msg = 'Node '+str(NodeID)+' state seting to '+ str(data['State'])
			return JSONResponse(data)
		return JSONResponse(data, status=400)

	return HttpResponse(status=404)
		

@csrf_exempt
def Node_cs_detail(request, NodeID): 
	try:
		node_obj = Nodes.objects.get(ID = NodeID)
	except Nodes.DoesNotExist:
		return HttpResponse(status=404)
	end = datetime.datetime.now()
	start = end - datetime.timedelta(days=1)
	node_cs = node_obj.current_states.filter(Added__range=[start, end])
	serializer = CurrentStateSerializer(instance=node_cs, many=True)
	return JSONResponse(serializer.data)


@csrf_exempt
def schedule_list(request):
	if request.method == 'GET':
		Tasks = TaskSchedule.objects.all()
		serializer = TaskslistSerializer(Tasks, many=True)
		data  = serializer.data
		#data['NodeID'] = data['NodeID']['ID']
		return JSONResponse(data)
	
	elif request.method == 'DELETE':
		data = JSONParser().parse(request)
		TaskID = data['TaskID']
		try:
			Task = TaskSchedule.objects.get(id = TaskID)
		except TaskSchedule.DoesNotExist:
			data['Msg'] = "Cant Find TaskID"
			return JSONResponse(data)
		Task.delete()
		data['Msg'] = "Task deleted!"
		return JSONResponse(data)

	return HttpResponse(status=404)



@csrf_exempt
def schedule_detail(request, NodeID):
	try:
		print('NodeID: {0}'.format(NodeID))
		node_obj = Nodes.objects.get(ID = NodeID)
		print(node_obj.ID)
		print(node_obj.Address)
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
		print(node_obj.ID)
		TaskSchedule.objects.create(NodeID = node_obj, triggerTime = triggerTime, Commend= commd, completed=completed, queued = queued)
		# schedulesTask(commd, Type, address):
		schedulesTask.apply_async((commd, node_obj.Type, node_obj.Address))
		data['NodeID'] = node_obj.ID
		
		return JSONResponse(data)

 	# elif request.method == 'DELETE':
	# 	house.delete()
	# 	return HttpResponse(status=204)
	# return HttpResponse(status=404)


