#/bin/bash
# run celery worker in background
supervisord -c /etc/supervisor/conf.d/supervisord.conf

# run server in foreground
gunicorn -b 0.0.0.0:5008 \
         --timeout 300 \
         -D \
         --workers 3 \
         --log-level debug \
         --log-file logs/gunicorn.log \
         --access-logfile logs/gunicorn-access.log \
         --error-logfile logs/gunicorn-error.log \
         --capture-output \
         --access-logformat '%(t)s %(p)s %(h)s "%r" %(s)s %(L)s %(b)s "%{Referer}i" "%{User-agent}i"' \
         app:app


tail -f /dev/null