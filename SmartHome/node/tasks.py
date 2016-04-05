from __future__ import absolute_import

from celery import shared_task
from celery.task.schedules import crontab
from celery.decorators import periodic_task

from SmartHome.api.models import *
from .XBee import XBee
from operator import xor

import platform
import time 
import pytz, datetime

try:
	if platform.system() == 'Linux':
		xbee = XBee("/dev/ttyUSB0")
		xbeeListen = XBee("/dev/ttyUSB2")
		xbeeIRreceive = XBee("/dev/ttyUSB1")

	elif platform.system() == 'Darwin':
		xbee = XBee("/dev/cu.usbserial-FTYVE8XDA")
		xbeeListen = XBee("/dev/cu.usbserial-FTYVE8XDC")
		xbeeIRreceive = XBee("/dev/cu.usbserial-FTYVE8XDB")
	else:
		xbee = XBee("COM7")
		xbeeListen = XBee("COM9")
		xbeeIRreceive = XBee("COM8")
	noSerialPortMode = False
except:
	noSerialPortMode = True
	print('No SerialPort Mode!!')

# Windows: xbee = XBee("COM7")
# OSX: xbee = XBee("/dev/cu.usbserial-FTYVE8XDA")
# Ubuntu: xbee = XBee("/dev/ttyUSB0")
timeNow = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
node_LastState_time = {'Nnode1':timeNow,  
			           'Nnode3':timeNow,
			           'Nnode4':timeNow,
			           'Nnode5':timeNow, 
			           'Lnode1':timeNow,
			           'Lnode2':timeNow,
			           'IRnode':timeNow} 

@shared_task
def test(param):
    return 'The test task executed with argument "%s" ' % param


@shared_task
def node_All_turn(state):
	if noSerialPortMode == False:
		xbee.node_All_turn(state)
		print('node_N_all_turn: '+ str(state))
	else:
		print('<In noSerialPortMode> node_All_turn({0})'.format(state))


@shared_task
def node_N_one_turn(state, address):
	if noSerialPortMode == False:
		xbee.node_N_one_turn(state, address)
		print('node_N_one_turn: '+str(state)+' Address =  '+ address)
	else:
		print('<In noSerialPortMode> node_N_one_turn({0}, {1})'.format(state, address))


@shared_task
def node_L_one_turn(state, address):
	if noSerialPortMode == False:
		xbee.node_L_one_turn(state, address)
		print('node_L_one_turn: '+str(state)+' Address =  '+ address)
	else:
		print('<In noSerialPortMode> node_L_one_turn({0}, {1})'.format(state, address))


@shared_task
def IR_node_send(commd):
	try:
		rawcode = IRcommend.objects.get(Commend = commd).RawCode
		# [pack1, pack2, pack3] = rawcode.split(",") 
	except:
		print("Can't find commd: {0}".format(commd))

	if noSerialPortMode == False:
		# xbee.IR_node_send(pack1, pack2, pack3)
		xbee.IRSend(rawcode)
		print('IR_node_send: {0}'.format(rawcode))
		# time.sleep(1)
		# node_one_reset.apply_async(('00 13 A2 00 40 C2 8B B7',))
	else:
		print('<In noSerialPortMode> IR_node_send({0}) RawCode: {1}'.format(commd, rawcode))


@shared_task
def schedulesTask(triggerTime, commd, Type, address):
	# tomorrow = datetime.utcnow() + timedelta(days=1)
	# .apply_async((val1, val2), eta=tomorrow)
	
	if(Type == 'IR'):
		IR_node_send.apply_async((commd, ), eta = triggerTime)
	elif Type =='N':
		node_N_one_turn.apply_async((commd, address), eta = triggerTime)
	elif Type =='L':
		node_L_one_turn.apply_async((commd, address), eta = triggerTime)

	if noSerialPortMode == False:
		print('schedulesTask({0}, {1}, {2}, {3})'.format(triggerTime, commd, Type, address))
	else:
		print('<In noSerialPortMode> schedulesTask({0}, {1} ,{2} , {3})'.format(triggerTime, commd, Type, address))
	
	
@shared_task
def node_all_reset():
	if noSerialPortMode == False:
		xbee.node_all_reset()
		print('ALL reset')
	else:
		print('<In noSerialPortMode> node_all_reset()')


@shared_task
def node_one_reset(address):
	if noSerialPortMode == False:
		xbee.node_one_reset(address)
		print(address+' reset!')
	else:
		print('<In noSerialPortMode> node_one_reset({0})'.format(address))


@periodic_task(run_every=(crontab(minute='*/3')), name="PcomdRouting", ignore_result=True)
def nodeCheck():
	if noSerialPortMode == False:
		xbee.Send_P_package()
		check_goddeadnode.apply_async(countdown=5) # 5秒後 檢查是否有死掉的node

		# address = {'00 13 A2 00 40 EC 3A A4':'Nnode1', '00 13 A2 00 40 EC 3A B7':'Nnode2', 
  #                  '00 13 A2 00 40 EC 3A 97':'Nnode3', '00 13 A2 00 40 B3 2D 41':'Nnode4',
  #                  '00 13 A2 00 40 EC 3A 98':'Nnode5', '00 13 A2 00 40 B3 31 65':'Nnode6',
  #                  '00 13 A2 00 40 B3 2D 4F':'Lnode1', '00 13 A2 00 40 B3 2D 5B':'Lnode2',
  #                  '00 13 A2 00 40 C2 8B B7':'IRnode'}
		# rep = xbee.Currentreport()
		# if type(rep) is list:
		# 	print(str(len(rep))+' nodes are online...')
		# 	for data in rep:
		# 		try:
		# 			rec_address = data['nodeAddress']
		# 			# print(rec_address)
		# 			# print(address)
		# 			try:
		# 				address.pop(rec_address)
		# 			except:
		# 				print('repeat address')
		# 			node_obj = Nodes.objects.get(Address = data['nodeAddress'])
		# 		except:
		# 			print('Error! undefined address: {0}'.format(rec_address))
		# 			# return
		# 			raise
		# 		addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
		# 		CurrentState.objects.create(NodeID = node_obj, State = data['Contect'], Added = addedtime)
		# 	if len(address) >0 :
		# 		for deadnode in address:
		# 			print('DeadNode: '+ address[deadnode])
		# 			node_one_reset.apply_async((deadnode,))
		# 			time.sleep(1)
		print('nodeCheck()')
	else:
		print('<In noSerialPortMode> nodeCheck()')


@shared_task
def nodeCurrentRepo():
	if noSerialPortMode == False:
		address = {'00 13 A2 00 40 EC 3A A4':'Nnode1',  
                   '00 13 A2 00 40 EC 3A 97':'Nnode3', '00 13 A2 00 40 B3 2D 41':'Nnode4',
                   '00 13 A2 00 40 EC 3A 98':'Nnode5', 
                   '00 13 A2 00 40 B3 2D 4F':'Lnode1', '00 13 A2 00 40 B3 2D 5B':'Lnode2',
                   '00 13 A2 00 40 EC 3A BE':'IRnode',
                   '00 13 A2 00 40 B5 AB 49':'Snode1', '00 13 A2 00 40 B3 2D 4C':'Snode2','00 13 A2 00 40 B3 31 65':'Nnode6'}  # '00 13 A2 00 40 EC 3A B7':'Nnode2', '00 13 A2 00 40 B3 31 65':'Nnode6',
		SL_pair = {'Snode1':'00 13 A2 00 40 B3 2D 4F', 'Snode2':'00 13 A2 00 40 B3 2D 5B'}

		# rep = xbeeListen.Receive()
		rep = xbee.Receive()
		# rep = xbee.Currentreport()
		if type(rep) is list:
			# print(str(len(rep))+' nodes are online...')
			print('收到'+ str(len(rep))+'個封包')
			for data in rep:
				print('封包內容：')	
				print(data)
				if 'state' in data:
					S_node_state = int(data['state'])
					rec_address = data['nodeAddress']
					try:
						node_name = address[rec_address]
					except:
						print('unKnow Arrdess: '+ data['nodeAddress'])
						continue

					if node_name in SL_pair:
						node_L_one_turn.apply_async((S_node_state, SL_pair[node_name]))
						print('收到'+node_name+', 下命令給'+SL_pair[node_name])
					try:
						node_obj = Nodes.objects.get(Address = rec_address)
					except:
						# 新增未知節點進資料庫
						# a = Nodes.objects.all()
						# new_NodeID = max([x.ID for x in a])+1
						# addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)  
						# Nodes.objects.create(ID = new_NodeID, Address = rec_address, Added = addedtime, Updated = addedtime)
						# print("New Node! Create than...")
						print('unKnow Arrdess: '+ data['nodeAddress'])
						# node_obj = Nodes.objects.get(Address = rec_address)
						continue
					laststate = NodeState.objects.all().filter(NodeID = node_obj).latest('Added').State
					laststate = int(laststate)
					# 修正 8 9 10 命令的問題
					if S_node_state == 8:
						laststate = xor(laststate, 4)
					elif S_node_state == 9:
						laststate = xor(laststate, 2)
					elif S_node_state == 10:
						laststate = xor(laststate, 1)
					addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
					NodeState.objects.create(NodeID = node_obj, State = laststate, Added = addedtime)

				elif 'Current' in data:
					rec_address = data['nodeAddress']
					try:
						nodeName = address[rec_address]
						node_obj = Nodes.objects.get(Address = data['nodeAddress'])
					except:
						# 新增未知節點進資料庫
						# a = Nodes.objects.all()
						# new_NodeID = max([x.ID for x in a])+1
						# addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)  
						# Nodes.objects.create(ID = new_NodeID, Address = rec_address, Added = addedtime, Updated = addedtime)
						# node_obj = Nodes.objects.get(Address = rec_address)
						print('unKnow Arrdess: '+ data['nodeAddress'])
						continue
						# print("New Node! Create than...")	
					addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
					node_LastState_time[nodeName] = addedtime
					CurrentState.objects.create(NodeID = node_obj, State = data['Current'], Added = addedtime)
					
				else:
					print('怪怪的')
				# try:
				# 	rec_address = data['nodeAddress']
				# 	print('收到地址： ' + rec_address)
				# 	# print(address)
				# 	try:
				# 		address.pop(rec_address)
				# 	except:
				# 		print('repeat address')
				# 	node_obj = Nodes.objects.get(Address = data['nodeAddress'])
				# except:
				# 	print('Error! undefined address: {0}'.format(rec_address))
				# 	try:
				# 		S_node_state = data['state']
				# 		print(S_node_state)
				# 		node_address = '00 13 A2 00 40 B3 2D 4F'
				# 		node_L_one_turn.apply_async((S_node_state, node_address))
				# 	except:
				# 		print('怪怪嘚')
				# 		continue
				# 	# return
				# 	# raise
				# 	continue
				# addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
				# CurrentState.objects.create(NodeID = node_obj, State = data['Current'], Added = addedtime)
			###### Reset 命令 #######
			# if len(address) >0 :
			# 	for deadnode in address:
			# 		print('DeadNode: '+ address[deadnode])
			# 		node_one_reset.apply_async((deadnode,))
			# 		time.sleep(0.5)
		# print(node_LastState_time)
		print('nodeRepo: {0}'.format(rep))
		# print(node_LastState_time)
	else:
		print('<In noSerialPortMode> node_CurrentRepo()')

@shared_task
def check_goddeadnode():
	if noSerialPortMode == False:
		print('check_goddeadnode()')
		address = {'Nnode1':'00 13 A2 00 40 EC 3A A4',  
                   'Nnode3':'00 13 A2 00 40 EC 3A 97', 'Nnode4':'00 13 A2 00 40 B3 2D 41',
                   'Nnode5':'00 13 A2 00 40 EC 3A 98', 
                   'Lnode1':'00 13 A2 00 40 B3 2D 4F', 'Lnode2':'00 13 A2 00 40 B3 2D 5B',
                   'IRnode':'00 13 A2 00 40 EC 3A BE',} 
		timeNow = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
		for keys in node_LastState_time.keys():
			if (timeNow - node_LastState_time[keys]).seconds > 120: #兩分鐘沒回應
				node_one_reset.apply_async((address[keys],))
				node_LastState_time[keys] = timeNow
				print(keys+' Reset!!')
	else:
		print('<In noSerialPortMode> check_goddeadnode()')

# @shared_task
# def nodeTest():
# 	if noSerialPortMode == False:
# 		print('All turn OFF')
# 		node_All_turn(0)
# 		time.sleep(1)
# 		print('ALL trun ON')
# 		node_All_turn(1)
# 		time.sleep(1)

# 		print('Nnode1 trun OFF')
# 		node_N_one_turn(0, '00 13 A2 00 40 EC 3A A4')
# 		time.sleep(1)
# 		print('Nnode1 trun ON')
# 		node_N_one_turn(1, '00 13 A2 00 40 EC 3A A4')
# 		time.sleep(1)
# 		print('Nnode2 trun OFF')
# 		node_N_one_turn(0, '00 13 A2 00 40 EC 3A B7')
# 		time.sleep(1)
# 		print('Nnode2 trun ON')
# 		node_N_one_turn(1, '00 13 A2 00 40 EC 3A B7')
# 		time.sleep(1)
# 		print('Nnode3 trun OFF')
# 		node_N_one_turn(0, '00 13 A2 00 40 EC 3A 97')
# 		time.sleep(1)
# 		print('Nnode3 trun ON')
# 		node_N_one_turn(1, '00 13 A2 00 40 EC 3A 97')
# 		time.sleep(1)
# 		print('Nnode4 trun OFF')
# 		node_N_one_turn(0, '00 13 A2 00 40 B3 2D 41')
# 		time.sleep(1)
# 		print('Nnode4 trun ON')
# 		node_N_one_turn(1, '00 13 A2 00 40 B3 2D 41')
# 		time.sleep(1)
# 		print('Nnode5 trun OFF')
# 		node_N_one_turn(0, '00 13 A2 00 40 EC 3A 98')
# 		time.sleep(1)
# 		print('Nnode5 trun ON')
# 		node_N_one_turn(1, '00 13 A2 00 40 EC 3A 98')
# 		time.sleep(1)
# 		print('Nnode6 trun OFF')
# 		node_N_one_turn(0, '00 13 A2 00 40 B3 31 65')
# 		time.sleep(1)
# 		print('Nnode6 trun ON')
# 		node_N_one_turn(1, '00 13 A2 00 40 B3 31 65')
# 		time.sleep(1)
# 		print('Lnode1 trun 2')
# 		node_L_one_turn(2, '00 13 A2 00 40 B3 2D 4F')
# 		time.sleep(1)
# 		print('Lnode1 trun 5')
# 		node_L_one_turn(5, '00 13 A2 00 40 B3 2D 4F')
# 		time.sleep(1)
# 		print('Lnode1 trun 9')
# 		node_L_one_turn(9, '00 13 A2 00 40 B3 2D 4F')
# 		time.sleep(1)
# 		print('Lnode2 trun 2')
# 		node_L_one_turn(2, '00 13 A2 00 40 B3 2D 5B')
# 		time.sleep(1)
# 		print('Lnode2 trun 5')
# 		node_L_one_turn(5, '00 13 A2 00 40 B3 2D 5B')
# 		time.sleep(1)
# 		print('Lnode2 trun 9')
# 		node_L_one_turn(9, '00 13 A2 00 40 B3 2D 5B')
# 		time.sleep(1)
# 		print('IRnode ON')
# 		IR_node_send('ON')
# 		time.sleep(1)
# 		print('IRnode UP')
# 		IR_node_send('UP')
# 		time.sleep(1)
# 		print('IRnode MUTE')
# 		IR_node_send('MUTE')
# 		time.sleep(1)

# 		print('Test Compelete!')
# 	else:
# 		print('<In noSerialPortMode> nodeTest')





