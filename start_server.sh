#!/bin/bash

# prepare log files and 
touch logs/gunicorn-access.log
touch logs/gunicorn.log

# run celery worker in background
supervisord -c /etc/supervisor/conf.d/supervisord.conf


gunicorn -b 0.0.0.0:5008 \
         --timeout 300 \
         --access-logfile logs/gunicorn-access.log \
         --error-logfile logs/gunicorn.log \
         --capture-output \
         --access-logformat '%(t)s %(p)s %(h)s "%r" %(s)s %(L)s %(b)s "%{Referer}i" "%{User-agent}i"' \
         app:app \

exec "$@"
