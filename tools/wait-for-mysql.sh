#!/bin/sh

while true
do
	if echo 'show databases;' | MYSQL_PWD=$MYSQL_PASSWORD mysql -h mysql -u root | grep mysql >/dev/null 2>&1; then
		echo mysql is ready
		exit;
	else
		echo wait for mysql
		sleep 2;
	fi
done
