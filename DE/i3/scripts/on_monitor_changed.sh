#!/bin/bash

set -e

sleep 2

displaynum=`ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##`

export XAUTHORITY=$(ps -C Xorg -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')
export DISPLAY=":$displaynum.0"

HDMI_STATUS=$(</sys/class/drm/card1/card1-HDMI-A-2/status )

if [ "connected" == "$HDMI_STATUS" ]; then
    mons -e left
    #notify-send --urgency=low -t 5000 "Graphics Update" "HDMI plugged in"
else
    mons -o
    #notify-send --urgency=low -t 5000 "Graphics Update" "External monitor disconnected"
fi

feh --bg-scale ~/.config/i3/wallpaper.jpg --no-fehbg
/home/midren/.config/polybar/launch.sh
