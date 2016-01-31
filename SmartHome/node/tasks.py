from __future__ import absolute_import

from celery import shared_task
from .XBee import XBee

# xbee = XBee("/dev/cu.usbserial-FTYVE8XDA")

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
