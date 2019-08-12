#!/bin/sh

/tools/wait-for-mysql.sh

if ! /tools/db-exists.sh safesurf ; then
	/tools/create-db.sh safesurf
	cd /web/webapp
	./manage.py migrate
fi

cd /web/webapp
gunicorn webapp.wsgi --workers=10 --bind=0.0.0.0:8000 --capture-output --log-file=/web/webapp/logs/django.log --log-level=debug --max-requests=100 --timeout=300

