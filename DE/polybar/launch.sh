#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch example
echo "---" | tee -a /tmp/topbar.log /tmp/topbar.log
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        echo $m
        MONITOR=$m polybar --reload topbar  >>/tmp/topbar.log 2>&1 &
    done
else
    polybar --reload topbar  >>/tmp/topbar.log 2>&1 &
fi


echo "Bars launched..."
