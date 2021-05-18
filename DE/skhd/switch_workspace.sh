#!/bin/bash
# Yabai workspace switcher with back and forth support

if [[ $# -eq 0 ]]; then
  /usr/bin/yabai -m space --focus recent
else
  current_ws=$(/usr/local/bin/yabai -m query --spaces --display | /usr/local/bin/jq 'map(select(."focused" == 1))[0].index')
  if [[ "$current_ws" != $1 ]]; then
    /usr/local/bin/yabai -m space --focus $1
    #a=$(yabai -m query --spaces --space $1 | jq -r '.windows[0] // empty')
    #if [[ ${#a} == 0 ]]; then
    #  yabai -m space --focus $1
    #else
    #  yabai -m window --focus $a
    #fi
  fi
fi

