#!/bin/bash
# i3 thread: https://faq.i3wm.org/question/150/how-to-launch-a-terminal-from-here/?answer=152#post-id-152
# From: https://gist.github.com/viking/5851049

args=("$@")

TERM=${args[0]}
CWD=''

cd `xcwd` && $TERM
