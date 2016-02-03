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
	elif platform.system() == 'Darwin':
		xbee = XBee("/dev/cu.usbserial-FTYVE8XDA")
	else:
		xbee = XBee("COM7")
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
		xbee.node_All_turn(State)
		print('node_N_all_turn: '+ str(State))
	else:
		print('In noSerialPortMode!!')


@shared_task
def node_N_one_turn(state, address):
	if noSerialPortMode == False:
		xbee.node_N_one_turn(state, address)
		print('node_N_one_turn: '+str(state)+' Address =  '+ address)
	else:
		print('In noSerialPortMode!!')


@shared_task
def node_L_one_turn(state, address):
	if noSerialPortMode == False:
		xbee.node_L_one_turn(state, address)
		print('node_L_one_turn: '+str(state)+' Address =  '+ address)
	else:
		print('In noSerialPortMode!!')

@shared_task
def IR_node_send(commd):
	if noSerialPortMode == False:
		xbee.IR_node_send(commd)
		print('IR: '+ commd)
	else:
		print('In noSerialPortMode!!')


@shared_task
def schedulesTask(commd, Type, address):
	if noSerialPortMode == False:
		if(Type == 'IR'):
			IR_node_send.apply_async((commd, ))
		elif Type =='N':
			node_N_one_turn.apply_async((commd, address))
		elif Type =='L':
			node_L_one_turn.apply_async((commd, address))	
		print('schedulesTask')
	else:
		print('In noSerialPortMode!!')
	
	
@shared_task
def node_all_reset():
	if noSerialPortMode == False:
		xbee.node_all_reset()
		print('ALL reset')
	else:
		print('In noSerialPortMode!!')


@shared_task
def node_one_reset(address):
	if noSerialPortMode == False:
		xbee.node_one_reset(address)
		print(address+' reset!')
	else:
		print('In noSerialPortMode!!')


@periodic_task(run_every=(crontab(minute='*/1')), name="PcomdRouting", ignore_result=True)
def PcomdRouting():
	if noSerialPortMode == False:
		address =['00 13 A2 00 40 EC 3A A4', '00 13 A2 00 40 EC 3A B7', '00 13 A2 00 40 EC 3A 97',
	    		  '00 13 A2 00 40 B3 2D 41', '00 13 A2 00 40 EC 3A 98', '00 13 A2 00 40 B3 31 65',
				  '00 13 A2 00 40 B3 2D 4F', '00 13 A2 00 40 B3 2D 5B', '00 13 A2 00 40 C2 8B B7']
		rep = xbee.Currentreport()
		if type(rep) is list:
			print(str(len(rep))+' nodes are online...')
			for data in rep:
				try:
					rec_address = data['nodeAddress']
					try:
						address.remove(rec_address)
					except:
						print('repeat address')
					node_obj = Nodes.objects.get(Address = data['nodeAddress'])
				except:
					print('Error! undefined address...')
					return
				addedtime = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None)
				CurrentState.objects.create(NodeID = node_obj, State = data['Contect'], Added = addedtime)
			if len(address) >0 :
				for deadnode in address:
					print('DeadNode: '+ deadnode)
					node_one_reset.apply_async((deadnode,))
					time.sleep(1)
		print('PcomdRouting...')
	else:
		print('In noSerialPortMode!!')


# node_all_reset.apply_async()


