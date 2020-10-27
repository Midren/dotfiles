#!/bin/sh
LC_MONETARY=uk_UA.UTF-8 rofi -show drun -modi drun,calc -calc-command "echo '{result}' | xclip -selection clipboard -rmlastnl" -kb-accept-custom "Control+c"
