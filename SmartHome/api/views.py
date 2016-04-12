import datetime, random
import pytz
from django.utils.dateparse import parse_datetime
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser

from .models import House, Nodes, NodeState, CurrentState, IRcommend, TaskSchedule
from .serializers import HouseSerializer, NodesSerializer, NodeslistSerializer, TaskslistSerializer, CurrentStateSerializer
from SmartHome.node.tasks import *

node_all_reset();

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
				if(node_obj.Address == '00 13 A2 00 40 B3 2D 4F'):
					node_L_one_turn.apply_async((commd, '00 13 A2 00 40 BA 79 B8'))
				elif(node_obj.Address == '00 13 A2 00 40 B3 2D 5B'):
					node_L_one_turn.apply_async((commd, '00 13 A2 00 40 BA 79 B9'))
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
		# Example : {"triggerTime": "2016-01-19T08:38:15.653108" , "State":0}
		triggerTime = parse_datetime(data['triggerTime'])
		print(triggerTime)
		triggerTime = pytz.timezone("Asia/Taipei").localize(triggerTime, is_dst=None)
		commd = data['State']
		completed = False
		queued = True
		print(node_obj.ID)
		TaskSchedule.objects.create(NodeID = node_obj, triggerTime = triggerTime, Commend= commd, completed=completed, queued = queued)
		# schedulesTask(triggerTime ,commd, Type, address):
		schedulesTask.apply_async((triggerTime, commd, node_obj.Type, node_obj.Address))
		data['NodeID'] = node_obj.ID
		return JSONResponse(data)


@csrf_exempt
def nodes_bill(request, Interval):
	if request.method == 'GET':
		HouseSetting = House.objects.all()
		serializer = HouseSerializer(HouseSetting, many=True)
		return JSONResponse(serializer.data)


@csrf_exempt
def house_bill(request, Interval):
	if request.method == 'GET':
		print("Bill GET request")
		print("0."+ str(datetime.datetime.now()))		
		year = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).year
		month = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).month
		day = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).day
		hour = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).hour

		if Interval == 'year': #今年
			Echarge = [546.199, 511.042, 0, 0, 0, 0, 0, 0, 0, 0 ,0 ,0]		
			for idx in range(12):
				timestamp = (datetime.datetime(year, idx+1, 1, 0, 0)+ datetime.timedelta(hours=8)).timestamp()*1000
				Echarge[idx] = [timestamp , Echarge[idx]]
			retern_data = {'Interval': Interval, 'data': Echarge}


		#####
			# cs_year = CurrentState.objects.all().filter(Added__year=year)
			# Echarge = []
			# for month in range(1,13): # 12個月
			# 	dayrange = (datetime.datetime(year, month%12+1, 1) - datetime.timedelta(days = 1)).day  # 算一個月的天數
			# 	Timetag1 = datetime.datetime.now()
			# 	print("1."+ str(Timetag1))
			# 	try:
			# 		cs_set = cs_year.filter(Added__month=month)
			# 		Timetag2 = datetime.datetime.now()
			# 		print("2."+ str(Timetag2))
			# 		print("  delta:"+ str(Timetag2-Timetag1))
			# 		#  累加取平均 算電費 回傳array
			# 		##############
			# 		state = cs_set.values_list('State', flat=True)
			# 		Echarge.append(sum(state)/len(state)*110/1000/1000*24*dayrange*3*3)
			# 		Timetag3 = datetime.datetime.now()
			# 		print("3."+ str(Timetag3))
			# 		print("  delta:"+ str(Timetag3-Timetag2))
			# 	except: #沒有表示當年沒後續月份資料 直接補零（比較快）
			# 		Echarge+=[0]*(12-month+1)
			# 		break
			# print("3."+ str(datetime.datetime.now()))
			# for idx in range(12):
			# 	timestamp = (datetime.datetime(year, idx+1, 1, 0, 0)+ datetime.timedelta(hours=8)).timestamp()*1000
			# 	Echarge[idx] = [timestamp , Echarge[idx]]
			# retern_data = {'Interval': Interval, 'data': Echarge}

		elif Interval == 'month': #這個月
			retern_data = {"Interval":"month","data":[[1454284800000.0,17.657],[1454371200000.0,17.651],[1454457600000.0,17.638],[1454544000000.0,17.624],[1454630400000.0,17.593],[1454716800000.0,17.605],[1454803200000.0,17.651],[1454889600000.0,17.589],[1454976000000.0,17.632],[1455062400000.0,17.602],[1455148800000.0,17.652],[1455235200000.0,17.606],[1455321600000.0,17.634],[1455408000000.0,17.598],[1455494400000.0,17.666],[1455580800000.0,17.614],[1455667200000.0,17.62007316666667],[1455753600000.0,17.649437666666664],[1455840000000.0,17.622947833333335],[1455926400000.0,17.59395366666667],[1456012800000.0,17.55722833333333],[1456099200000.0,0],[1456185600000.0,0],[1456272000000.0,0],[1456358400000.0,0],[1456444800000.0,0],[1456531200000.0,0],[1456617600000.0,0],[1456704000000.0,0]]}

			# ######
			# print('month'+str(month))
			# cs_month = CurrentState.objects.all().filter(Added__year=year).filter(Added__month=month)
			# print(cs_month)
			# dayrange = (datetime.datetime(year, month%12+1, 1) - datetime.timedelta(days = 1)).day  # 算一個月的天數
			# temp = []
			# for i in range(dayrange):
			# 	temp.append([0,0])
			# State_list = cs_month.values_list('Added', 'State')
			# ## Debug 
			# Timetag1 = datetime.datetime.now()
			# print("1."+ str(Timetag1))
			# ## 

			# # ## 這裡很慢啊...約10秒
			# for x in State_list:
			# 	day = x[0].astimezone(pytz.timezone("Asia/Taipei")).day
			# 	temp[day-1][0]+=x[1] #第一個存值
			# 	temp[day-1][1]+=1 #第二個存數量
			# # ##
			# Timetag2 = datetime.datetime.now()
			# print("2."+ str(Timetag2))
			# print("  delta:"+ str(Timetag2-Timetag1))
			# ##
			# Echarge = []
			# for idx, y in enumerate(temp):
			# 	timestamp = (datetime.datetime(year, month, idx+1, 0, 0)+ datetime.timedelta(hours=8)).timestamp()*1000
			# 	if y[1] != 0:
			# 		Echarge.append([timestamp, y[0]/y[1]*110/1000/1000*24*3*3])
			# 	else:
			# 		Echarge.append([timestamp, 0])
			# Echarge = []
			# dayrange = (datetime.datetime(year, month%12+1, 1) - datetime.timedelta(days = 1)).day  # 算一個月的天數
			# for day in range(1,dayrange+1): # 一個月的日數
			# 	Timetag1 = datetime.datetime.now()
			# 	print("1."+ str(Timetag1))
			# 	try:
			# 		cs_set = cs_month.filter(Added__day=day)
			# 		Timetag2 = datetime.datetime.now()
			# 		print("2."+ str(Timetag2))
			# 		print("  delta:"+ str(Timetag2-Timetag1))
			# 		state = cs_set.values_list('State', flat=True)
			# 		Timetag3 = datetime.datetime.now()
			# 		print("3."+ str(Timetag3))
			# 		print("  delta:"+ str(Timetag3-Timetag2))
			# 		Echarge.append(sum(state)/len(state)*110/1000/1000*24*3)

			# 	except:
			# 		Echarge+=[0]*(dayrange-day+1)
			# 		break
			# retern_data = {'Interval': Interval, 'data': Echarge}

		elif Interval == 'day': #今天
			# retern_data = {"Interval":"day","data":[[1456185600000.0,random.randint(10,100)],[1456189200000.0,random.randint(10,100)],[1456192800000.0,random.randint(10,100)],[1456196400000.0,random.randint(10,100)],[1456200000000.0,random.randint(10,100)],[1456203600000.0,random.randint(10,100)],[1456207200000.0,random.randint(10,100)],[1456210800000.0,0],[1456214400000.0,0],[1456218000000.0,0],[1456221600000.0,0],[1456225200000.0,0],[1456228800000.0,0],[1456232400000.0,0],[1456236000000.0,0],[1456239600000.0,0],[1456243200000.0,0],[1456246800000.0,0],[1456250400000.0,0],[1456254000000.0,0],[1456257600000.0,0],[1456261200000.0,0],[1456264800000.0,0],[1456268400000.0,0]]}


			#######
			cs_day = CurrentState.objects.all().filter(Added__year=year).filter(Added__month=month).filter(Added__day=day)
			temp = []
			for i in range(24):
				temp.append([0,0])
			State_list = cs_day.values_list('Added', 'State')
			# ## Debug 
			# Timetag1 = datetime.datetime.now()
			# print("1."+ str(Timetag1))
			# ##
			# ## 這裡很慢啊...約10秒
			for x in State_list:
				hour = x[0].astimezone(pytz.timezone("Asia/Taipei")).hour
				temp[hour-1][0]+=x[1] #第一個存值
				temp[hour-1][1]+=1 #第二個存數量
			# # ##
			# Timetag2 = datetime.datetime.now()
			# print("2."+ str(Timetag2))
			# print("  delta:"+ str(Timetag2-Timetag1))
			# ##
			Echarge = []
			for idx, y in enumerate(temp):
				timestamp = (datetime.datetime(year, month, day, idx, 0)+ datetime.timedelta(hours=8)).timestamp()*1000
				if y[1] != 0:
					Echarge.append([timestamp, y[0]/y[1]*110/100/1000*3*60]) 
				else:
					Echarge.append([timestamp, 0])
			retern_data = {'Interval': Interval, 'data': Echarge}

		elif Interval == 'hour':  #這個小時
			cs_hour = CurrentState.objects.all().filter(Added__year=year).filter(Added__month=month).filter(Added__day=day).filter(Added__hour=hour)
			temp = []
			for i in range(60):
				temp.append([0,0])
			State_list = cs_hour.values_list('Added', 'State')
			for x in State_list:
				minute = x[0].astimezone(pytz.timezone("Asia/Taipei")).minute
				temp[minute][0]+=x[1] #第一個存值
				temp[minute][1]+=1 #第二個存數量
			Echarge = []
			for idx, y in enumerate(temp):
				timestamp = (datetime.datetime(year, month, day, hour, idx)+ datetime.timedelta(hours=8)).timestamp()
				if y[1] != 0:
					Echarge.append([timestamp, y[0]/y[1]*110/100/1000*3])
				else:
					Echarge.append([timestamp, 0])
			retern_data = {'Interval': Interval, 'data': Echarge}
		elif Interval == 'node': #node列表
		# [["1", "台燈", "客廳", "0", "10"],
    	#  ["2", "電風扇", "客廳", "1", "5"],
    	#  ["3", "微波爐", "客廳", "1", "80"]]
			node_objs = Nodes.objects.all().order_by('ID')
			# 客廳、主臥房
			retern_data = []
			for x in  node_objs:
				ID = str(x.ID)
				Appl = x.Appliances
				Group = str(x.Group)
				try:
					state = x.states.last().State
				except:
					state = ''
				try:
					Cstate = str(float(x.current_states.last().State)*10)
				except:
					Cstate = ''
				retern_data.append([ID, Appl, Group, state, Cstate])


		return JSONResponse(retern_data)


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


@csrf_exempt #情境模式
def env_control(request, env_case): 
	if env_case == 'goOUT': # 全關
		node_All_turn.apply_async((0, ))
		addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
		for NodeID in range(1,9):
			node_obj = Nodes.objects.get(ID = NodeID)
			NodeState.objects.create(NodeID = node_obj, State = 0, Added = addedtime)
		print('<env_control> goOUT: node all close')

	elif env_case == 'protect' : # 唯獨1號node打開
		addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
		node_All_turn.apply_async((0, ))
		for NodeID in range(2,9):
			node_obj = Nodes.objects.get(ID = NodeID)
			NodeState.objects.create(NodeID = node_obj, State = 0, Added = addedtime)
		node_obj = Nodes.objects.get(ID = 1) 
		node_N_one_turn.apply_async((1, node_obj.Address, ))
		NodeState.objects.create(NodeID = node_obj, State = 1, Added = addedtime)
		print('<env_control> protect: only one node turn on')

	elif env_case == 'sleep' : # 只開L node的中間按鈕
		addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
		node_obj1 = Nodes.objects.get(ID = 7) 
		node_obj2 = Nodes.objects.get(ID = 8) 
		node_All_turn.apply_async((0, ))
		for NodeID in range(1,9):
			node_obj = Nodes.objects.get(ID = NodeID)
			NodeState.objects.create(NodeID = node_obj, State = 0, Added = addedtime)
		addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
		node_L_one_turn.apply_async((5, node_obj1.Address, ))
		node_L_one_turn.apply_async((5, node_obj2.Address, ))
		NodeState.objects.create(NodeID = node_obj1, State = 5, Added = addedtime)
		NodeState.objects.create(NodeID = node_obj2, State = 5, Added = addedtime)
		print('<env_control> sleep: only two L node turn on')

	elif env_case == 'comeHome':
		node_All_turn.apply_async((1, ))
		addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
		for NodeID in range(1,9):
			node_obj = Nodes.objects.get(ID = NodeID)
			if(NodeID == 7 or NodeID == 8):
				NodeState.objects.create(NodeID = node_obj, State = 7, Added = addedtime)
			else:
				NodeState.objects.create(NodeID = node_obj, State = 1, Added = addedtime)
		print('<env_control> comeHome: node all turn on')

	return HttpResponse(status=204)


@csrf_exempt
def IRset(request, commend): 
	# ['12 ...', '4A 51  ...', '...']
	IRpack = xbeeIRreceive.IRReceive()
	if IRpack == None:
		print('IRset return nothing!')
		return HttpResponse(status=404)
	else:
		print('IR Receive: {0}'.format(IRpack))
		try:
			obj = IRcommend.objects.get(Commend = commend)
			# rawcode = obj.RawCode 
			rawcode = IRpack
			obj.RawCode = rawcode
			obj.save()
		except: # 如果找不到，則新增
			# rawcode = ', '.join(IRpack)
			rawcode = IRpack[0]
			node_obj = Nodes.objects.get(ID = 9)
			IRcommend.objects.create(NodeID = node_obj, Commend = commend, RawCode = rawcode)
		# 找到就回傳
		data = {'commend': commend, 'RawCode': rawcode}
		return JSONResponse(data)

@csrf_exempt
def ResetAll(request): 
	node_all_reset()
	print('ResetAll')
	return HttpResponse(status=204)

@csrf_exempt
def ResetIRcommand(request): 
	print('ResetIRcommand!')
	defaultIRcommand = {'power': 	"7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 87 78 EF 10",
					   	'chup':  	"7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 57 A8 EF 10",
    					'chdown': 	"7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 C7 38 EF 10",
    					'voiceup': 	"7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 E7 18 EF 10",
    					'voicedown':"7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 D7 28 EF 10",
    					'mute':     "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 05 FA EF 10",
					    'back':     "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 07 F8 EF 10",
    					'tv1':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 15 EA EF 10",
 					   	'tv2':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 0D F2 EF 10",
    					'tv3':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 35 CA EF 10",
					    'tv4':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 95 6A EF 10",
					    'tv5':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 8D 72 EF 10",
					    'tv6':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 85 7A EF 10",
					    'tv7':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 D5 2A EF 10",
    					'tv8':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 CD 32 EF 10",
					    'tv9':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 C5 3A EF 10",
    					'tv0':      "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 4D B2 EF 10",
					    'enter':    "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 8F 70 EF 10",
  	  					'language': "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 45 BA EF 10",
    					'display':  "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 EF 10 EF 10",
					    'scan':     "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 A5 5A EF 10",
    					'info':     "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 AF 50 EF 10",
    					'energy':   "7E 00 16 10 00 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 01 20 00 2F D0 EF 10",
    					'boardcast':"7E 00 16 10 00 00 00 00 00 00 00 00 00 FF FE 00 00 72 01 20 00 7F 80 EF 10",
    					}
	obj = IRcommend.objects.all()
	obj.delete()
	node_obj = Nodes.objects.get(ID = 9)
	for keys in defaultIRcommand.keys():
		IRcommend.objects.create(NodeID = node_obj, Commend = keys, RawCode = defaultIRcommand[keys])
	return HttpResponse(status=204)
	



