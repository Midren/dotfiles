#!/bin/sh

killall -q picom

picom --conf ~/.config/picom/picom.conf --experimental-backends
