#!/bin/sh

while true; do
	if docker ps | grep $1 >/dev/null; then
		echo container $1 is up
		exit
	else
		echo wait for container $1
		sleep 5
	fi
done
