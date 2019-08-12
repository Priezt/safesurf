#!/bin/sh

chromium-browser --test-type --no-sandbox --window-size=${WINDOW_WIDTH},${WINDOW_HEIGHT} --window-position=0,0 `cat /url`

ps auxww | grep x11vnc | grep -v grep | awk '{print $2}' | xargs kill -9

