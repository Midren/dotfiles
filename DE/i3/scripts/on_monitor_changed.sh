#!/bin/env bash
set -e

RELOAD=1


while getopts "h?r:" opt; do
        case "$opt" in
        h|\?)
            show_help
            exit 0
            ;;
        r)  RELOAD=$OPTARG
            ;;
        esac
done

sleep 2

displaynum=`ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##`

#export XAUTHORITY=$(ps -C Xorg -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')
export XAUTHORITY=/home/midren/.Xauthority
export DISPLAY=":$displaynum.0"

HDMI_STATUS=$(</sys/class/drm/card1/card1-HDMI-A-2/status )

if [ "connected" == "$HDMI_STATUS" ]; then
    mons -e left
else
    mons -o
fi

if [[ $RELOAD == 1 ]]; then
    feh --bg-scale ~/.config/i3/wallpaper.jpg --no-fehbg
    ~/.config/polybar/launch.sh
fi
