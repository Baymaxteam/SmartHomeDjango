
from __future__ import absolute_import

import os
from celery import Celery, platforms

from django.apps import AppConfig
from django.conf import settings

import time
from celery.schedules import crontab
from datetime import timedelta


platforms.C_FORCE_ROOT = True

if not settings.configured:
    # set the default Django settings module for the 'celery' program.
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings.local")  # pragma: no cover



app = Celery('SmartHome')
# app.conf.update(
#     ELERYBEAT_SCHEDULE = {'add-every—5-seconds': {
#         'task': 'add',
#         'schedule': timedelta(seconds=5),
#         'args': (16, 16)
#     },
#     }
# )

class CeleryConfig(AppConfig):
    name = 'SmartHome.taskapp'
    verbose_name = 'Celery Config'

    def ready(self):
        # Using a string here means the worker will not have to
        # pickle the object when using Windows.
        app.config_from_object('django.conf:settings')
        app.autodiscover_tasks(lambda: settings.INSTALLED_APPS, force=True)

        # if hasattr(settings, 'RAVEN_CONFIG'):
        #     # Celery signal registration
        #     from raven import Client as RavenClient
        #     from raven.contrib.celery import register_signal as raven_register_signal
        #     from raven.contrib.celery import register_logger_signal as raven_register_logger_signal

        #     raven_client = RavenClient(dsn=settings.RAVEN_CONFIG['DSN'])
        #     raven_register_logger_signal(raven_client)
        #     raven_register_signal(raven_client)

        # if hasattr(settings, 'OPBEAT'):
        #     from opbeat.contrib.django.models import client as opbeat_client
        #     from opbeat.contrib.django.models import logger as opbeat_logger
        #     from opbeat.contrib.django.models import register_handlers as opbeat_register_handlers
        #     from opbeat.contrib.celery import register_signal as opbeat_register_signal

        #     try:
        #         opbeat_register_signal(opbeat_client)
        #     except Exception as e:
        #         opbeat_logger.exception('Failed installing celery hook: %s' % e)

        #     if 'opbeat.contrib.django' in settings.INSTALLED_APPS:
        #         opbeat_register_handlers()

# @app.on_after_configure.connect
# def setup_periodic_tasks(sender, **kwargs):
#     # Calls test('hello') every 10 seconds.
#     sender.add_periodic_task(10.0, test.s('hello'), name='add every 10')

#     # Calls test('world') every 30 seconds
#     sender.add_periodic_task(30.0, test.s('world'), expires=10)

 

@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))  # pragma: no cover

# @app.task()
# def add(x, y):
#     return x + y

# @app.task
# def test(arg):
#     print(arg)

