#/bin/bash

# run server in background
gunicorn -b 0.0.0.0:5008  --timeout 300 --workers 3 --log-level debug --log-file - app:app

# run worker in foreground
celery worker -A tasks.celery_client -l info
