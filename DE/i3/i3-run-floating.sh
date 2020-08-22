#!/bin/env bash
eval "$1 &"

pid="$!"

# Wait for the window to open and grab its window ID
winid=''
while : ; do
    winid="`wmctrl -lp | awk -F" " -vpid=$pid ' pid == $3 { print $1; exit}'`"
        [[ -z "${winid}" ]] || break
    done

    # Focus the window we found
    wmctrl -ia "${winid}"

    # Make it float
    i3-msg floating enable > /dev/null;

    i3-msg 'resize shrink width 10000px; resize grow width 800px; resize shrink height 10000px; resize grow height 800px;' > /dev/null

    # Wait for the application to quit
    wait "${pid}";
