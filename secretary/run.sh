#!/bin/sh

/tools/wait-for-mysql.sh

if ! /tools/db-exists.sh guac ; then
	echo create db guac
	/tools/create-db.sh guac
	echo get guacamole initdb sql file
	docker run --rm guacamole/guacamole:0.9.14 /opt/guacamole/bin/initdb.sh --mysql > /initdb.sql
	echo create guacamole tables
	cat /initdb.sql | MYSQL_PWD=$MYSQL_PASSWORD mysql -h mysql -u root guac
else
	echo db guac already exists
fi

/tools/wait-for-container-up.sh safesurf_guacamole_1
sleep 30

# patch guacamole to no-auth
GUACAMOLE_CONTAINER_NAME=safesurf_guacamole_1
if docker exec $GUACAMOLE_CONTAINER_NAME cat /noauth-config.xml 2>/dev/null | grep configs > /dev/null; then
	echo guacamole is already patched
else
	echo patch guacamole to no-auth
	docker cp /guacamole/noauth-config.xml $GUACAMOLE_CONTAINER_NAME:/noauth-config.xml
	docker cp /guacamole/guacamole-auth-noauth-0.9.14.jar $GUACAMOLE_CONTAINER_NAME:/guacamole-auth-noauth.jar
	docker cp $GUACAMOLE_CONTAINER_NAME:/opt/guacamole/bin/start.sh /start.sh
	cd /guacamole
	cat /start.sh | sed '/mysql-password/rpatch_for_start.sh' > /start.sh.patched
	chmod +x /start.sh.patched
	docker cp /start.sh.patched $GUACAMOLE_CONTAINER_NAME:/opt/guacamole/bin/start.sh
	docker restart $GUACAMOLE_CONTAINER_NAME
fi

while true; do
	sleep 1
done

