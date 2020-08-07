#!/bin/sh
rofi -show drun -modi drun,calc -calc-command "echo '{result}' | xclip -selection clipboard -rmlastnl" -kb-accept-custom "Control+c"
