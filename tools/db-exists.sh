#!/bin/sh

if echo 'show databases;' | MYSQL_PWD=$MYSQL_PASSWORD mysql -h mysql -u root | grep $1 >/dev/null 2>&1; then
	exit 0
else
	exit 1
fi
