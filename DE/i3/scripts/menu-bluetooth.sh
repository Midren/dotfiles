#!/usr/bin/env bash
#Reference: https://github.com/sQVe/scripts/blob/master/i3/menu-bluetooth.sh

#  ┏┳┓┏━╸┏┓╻╻ ╻   ┏┓ ╻  ╻ ╻┏━╸╺┳╸┏━┓┏━┓╺┳╸╻ ╻
#  ┃┃┃┣╸ ┃┗┫┃ ┃   ┣┻┓┃  ┃ ┃┣╸  ┃ ┃ ┃┃ ┃ ┃ ┣━┫
#  ╹ ╹┗━╸╹ ╹┗━┛   ┗━┛┗━╸┗━┛┗━╸ ╹ ┗━┛┗━┛ ╹ ╹ ╹

devices=$(bluetoothctl paired-devices | cut -d ' ' -f 2-)
choice="$(echo "$devices" | cut -d ' ' -f 2- | rofi -dmenu -p 'BLE device: ')"
mac=$(echo "$devices" | rg "$choice" | awk '{print $1}')

if [[ -n "$mac" ]]; then
  connected=$(bluetoothctl info "$mac" | rg 'Connected: yes' | wc -l)

  if [[ connected -eq 1 ]]; then
    bluetoothctl disconnect "$mac" && notify-send -i bluetooth "Bluetooth" "Disconnected: $choice"
  else
    bluetoothctl connect "$mac" && notify-send -i bluetooth "Bluetooth" "Connected: $choice"
  fi
fi
