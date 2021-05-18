#!/bin/bash
# Yabai workspace switcher with back and forth support

if [[ $# -eq 0 ]]; then
  yabai -m window --space recent
  #yabai -m space --focus recent
else
  current_ws=$(yabai -m query --spaces --display | jq 'map(select(."focused" == 1))[0].index')
  if [[ "$current_ws" == $1 ]]; then
    # go to previous workspace
    yabai -m window --space recent
    #yabai -m space --focus recent
  else
    # else, go to the workspace specified
    yabai -m window --space $1
    #yabai -m space --focus $1
  fi
fi

