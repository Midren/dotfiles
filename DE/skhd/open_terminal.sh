#!/usr/bin/env bash
# opens a terminal window on the correct display, triggered by hotkeys from SKHD

# Terminal opens on primary display, nothing special if already on it
display=$(yabai -m query --displays --display | jq ".index")

if [[ ${display:-100} -eq 1 ]]; then
  # Just open the terminal if on the primary (first) display
  #/Applications/Alacritty.app/Contents/MacOS/alacritty
  kitty -1 -d ~/
else
  # otherwise, track the current space to open the window and move it to the focused space
  # after it starts up on the primary display
  space=$(yabai -m query --spaces --display | jq 'map(select(."focused" == 1))[0].index')
  #/Applications/Alacritty.app/Contents/MacOS/alacritty
  kitty -d ~/
  sleep 0.1
  yabai -m window --space "${space}"
  yabai -m space --focus "${space}"
fi

