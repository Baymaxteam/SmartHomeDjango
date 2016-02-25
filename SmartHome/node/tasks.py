from __future__ import absolute_import

from celery import shared_task
from celery.task.schedules import crontab
from celery.decorators import periodic_task

from SmartHome.api.models import *
from .XBee import XBee

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
	if noSerialPortMode == False:
		xbee.IR_node_send(commd)
		print('IR: '+ commd)
		# time.sleep(1)
		# node_one_reset.apply_async(('00 13 A2 00 40 C2 8B B7',))
	else:
		print('<In noSerialPortMode> IR_node_send({0})'.format(commd))


@shared_task
def schedulesTask(triggerTime, commd, Type, address):
	# tomorrow = datetime.utcnow() + timedelta(days=1)
	# .apply_async((val1, val2), eta=tomorrow)

	if noSerialPortMode == False:
		if(Type == 'IR'):
			IR_node_send.apply_async((commd, ), eta = triggerTime)
		elif Type =='N':
			node_N_one_turn.apply_async((commd, address), eta = triggerTime)
		elif Type =='L':
			node_L_one_turn.apply_async((commd, address), eta = triggerTime)	
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


@periodic_task(run_every=(crontab(minute='*/5')), name="PcomdRouting", ignore_result=True)
def nodeCheck():
	if noSerialPortMode == False:
		xbee.Send_P_package()
		nodeCurrentRepo.apply_async(countdown=60) # 60秒後 去接收回傳的封包

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
                   '00 13 A2 00 40 C2 8B B7':'IRnode'}  # '00 13 A2 00 40 EC 3A B7':'Nnode2', '00 13 A2 00 40 B3 31 65':'Nnode6',
		rep = xbeeListen.Receive()
		# rep = xbee.Currentreport()
		if type(rep) is list:
			print(str(len(rep))+' nodes are online...')
			for data in rep:
				try:
					rec_address = data['nodeAddress']
					# print(rec_address)
					# print(address)
					try:
						address.pop(rec_address)
					except:
						print('repeat address')
					node_obj = Nodes.objects.get(Address = data['nodeAddress'])
				except:
					print('Error! undefined address: {0}'.format(rec_address))
					# return
					raise
				addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
				CurrentState.objects.create(NodeID = node_obj, State = data['Contect'], Added = addedtime)
			if len(address) >0 :
				for deadnode in address:
					print('DeadNode: '+ address[deadnode])
					node_one_reset.apply_async((deadnode,))
					time.sleep(1)

		print('nodeCurrentRepo: {0}'.format(rep))
	else:
		print('<In noSerialPortMode> node_CurrentRepo()')



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





