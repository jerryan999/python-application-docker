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
         --access-logformat "{'remote_ip':'%(h)s','request_id':'%({X-Request-Id}i)s','response_code':'%(s)s','request_method':'%(m)s','request_path':'%(U)s','request_querystring':'%(q)s','request_timetaken':'%(D)s','response_length':'%(B)s'}" \
         app:app \

exec "$@"
