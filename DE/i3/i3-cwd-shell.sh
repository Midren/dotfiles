#!/bin/bash
# i3 thread: https://faq.i3wm.org/question/150/how-to-launch-a-terminal-from-here/?answer=152#post-id-152
# From: https://gist.github.com/viking/5851049

args=("$@")

TERM=${args[0]}
CWD=''

# Get window ID
ID=$(xdpyinfo | grep focus | cut -f4 -d " ")

# Get PID of process whose window this is
PID=$(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3)

# Get last child process (shell, vim, etc)
if [ -n "$PID" ]; then
  TREE=$(pstree -lpA $PID | tail -n 1)
  PID=$(echo $TREE | awk -F'---' '{print $NF}' | sed -re 's/[^0-9]//g')

  # If we find the working directory, run the command in that directory
  if [ -e "/proc/$PID/cwd" ]; then
    CWD=$(readlink /proc/$PID/cwd)
  fi
fi
unset 'args[0]'
args="${args[@]}"
if [ -n "$CWD" ]; then
  cd $CWD && $TERM $args
else
  $TERM $args
fi
