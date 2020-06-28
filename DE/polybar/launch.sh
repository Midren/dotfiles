#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
# When external monitor is not connected on start up
# laptop screen is eDP-1 instead of eDP-1-1
tray_output=$(xrandr | grep "eDP" | cut -d' ' -f1)

for m in $outputs; do
  if [[ $m == "HDMI-0" ]]; then
      tray_output=$m
      echo tray output $tray_output
  fi
done


# Launch example
echo "---" | tee -a /tmp/topbar.log /tmp/topbar.log
for m in $outputs; do
    echo $m
    TRAY_POSITION=none
    if [[ $m == $tray_output ]]; then
      TRAY_POSITION=center
    fi
    export TRAY_POSITION
    MONITOR=$m polybar --reload topbar  >>/tmp/topbar.log 2>&1 &
    disown
done

echo "Bars launched..."
