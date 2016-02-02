from __future__ import absolute_import

from celery import shared_task
from celery.task.schedules import crontab
from celery.decorators import periodic_task

from SmartHome.api.models import Nodes
from .XBee import XBee

# import platform

# if platform.system() == 'Linux':
# 	xbee = XBee("/dev/ttyUSB0")
# elif platform.system() == 'Darwin':
# 	xbee = XBee("/dev/cu.usbserial-FTYVE8XDA")
# else:
# 	xbee = XBee("COM7")


# Windows: xbee = XBee("COM7")
# OSX: xbee = XBee("/dev/cu.usbserial-FTYVE8XDA")
# Ubuntu: xbee = XBee("/dev/ttyUSB0")

@shared_task
def test(param):
    return 'The test task executed with argument "%s" ' % param

@shared_task
def node_N_all_open():
	# xbee.node_N_all_open()
	print('node_N_all_open')

@shared_task
def node_N_all_close():
	# xbee.node_N_all_close()
	print('node_N_all_close')

@shared_task
def node_N_one_open(address):
	# xbee.node_N_one_open(address)
	print('node_N_one_open')

@shared_task
def node_N_one_close(address):
	# xbee.node_N_one_open(address)
	print('node_N_one_close')

@shared_task
def PeriodicTest(time):
	# node_obj = Nodes.objects.get(ID=1)
	# if(node_obj.states.last().State == '1'):
	# 	print('PeriodicTest per 15sec')
	# 	PeriodicTest.apply_async((15,), countdown=15)
	# else:
	# 	print('StopTask!')
	print('nothing')
	
	
	

# @periodic_task(run_every=(crontab(minute='*/1')), name="PcomdRouting", ignore_result=True)
# def PcomdRouting():
#     print('PcomdRouting')