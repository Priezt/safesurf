#!/bin/bash

#service dbus start
#pulseaudio > /var/log/pulseaudio.log &

if [ "$@" == "dummy" ]; then
	while true; do
		sleep 1;
	done
fi


echo $@ > /url

echo url: $@
echo width: $WINDOW_WIDTH
echo height: $WINDOW_HEIGHT
FD_GEOM=1920x1080 x11vnc -nopw -create -clip ${WINDOW_WIDTH}x${WINDOW_HEIGHT}+0+0


