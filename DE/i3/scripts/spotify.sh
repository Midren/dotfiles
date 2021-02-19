#!/bin/bash

# Temporary file to record the terminal state
SPOTIFY_STATE=/tmp/spotify_state

usage() {
    echo "Open/closes a spotify from scratchpad"
    echo "Usage: ./spotify.sh <start|toggle>"
}

spotify_launch() {
    spotify &
    local spotify_pid=$!
    local winid=''
    # Wait for terminal to open
    echo $spotify_pid
    xdotool search --sync --onlyvisible --pid $spotify_pid > /dev/null
    i3-msg -q mark spotify # Mark the window so we can identify it
    i3-msg -q [con_mark=spotify] move scratchpad
    echo "closed" > $SPOTIFY_STATE
}

spotify_toggle()  {
    i3-msg -q [con_mark='spotify'] scratchpad show
    ret_val=$?
    if [ $ret_val -ne 0 ]; then
        spotify_launch
        sleep 5
        spotify_toggle
    fi
}

if [ $# != 1 ]; then
    usage
    exit 1
else
    case $1 in
        start) spotify_launch;;
        toggle) spotify_toggle;;
        *)  usage; exit 1;;
    esac
fi
