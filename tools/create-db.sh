#!/bin/sh

echo create database $1 | MYSQL_PWD=$MYSQL_PASSWORD mysql -h mysql -u root
