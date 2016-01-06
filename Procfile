web: gunicorn config.wsgi:application
worker: newrelic-admin run-program celery worker --app=SmartHome.taskapp --loglevel=info
