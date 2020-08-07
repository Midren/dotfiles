#!/usr/bin/env bash
# Reference: https://github.com/sQVe/scripts/blob/master/i3/menu-state.sh

#  ┏┳┓┏━╸┏┓╻╻ ╻   ┏━┓╺┳╸┏━┓╺┳╸┏━╸
#  ┃┃┃┣╸ ┃┗┫┃ ┃   ┗━┓ ┃ ┣━┫ ┃ ┣╸
#  ╹ ╹┗━╸╹ ╹┗━┛   ┗━┛ ╹ ╹ ╹ ╹ ┗━╸

exits=(
  '<span font_desc="TerminessTTF Nerd Font Mono 13">🗘</span> reboot'
  '<span font_desc="TerminessTTF Nerd Font Mono 18">⏾</span> suspend'
  '<span font_desc="TerminessTTF Nerd Font Mono 18">⏻</span> shutdown'
  '<span font_desc="TerminessTTF Nerd Font Mono 18"></span> exit'
  '<span font_desc="TerminessTTF Nerd Font Mono 18"></span> lock'
)

if [[ -x "$(command -v optimus-manager)" ]]; then
  gpu=$(optimus-manager --print-mode | rg -o "intel|nvidia")

  case "$gpu" in
  intel)
    exits+=('<span font_desc="TerminessTTF Nerd Font Mono 18">﬙</span> gpu nvidia')
    ;;
  nvidia)
    exits+=('<span font_desc="TerminessTTF Nerd Font Mono 18">﬙</span> gpu intel')
    ;;
  esac
fi

choice="$(printf '%s\n' "${exits[@]}" | rofi -dmenu -markup-rows -p 'exit: ')"

choice=($choice)
choice=${choice[${#choice[@]}-1]}
case "$choice" in
exit)
  i3-msg exit
  ;;
lock)
  $HOME/.config/i3/i3-lock-and-blur.sh
  ;;
shutdown)
  shutdown -P now
  ;;
gpu*)
  optimus-manager --no-confirm --switch "$(rg -o "intel|nvidia" <<<"$choice")"
  ;;
lock)
  xkblayout-state set 0
  ~/.config/i3/i3-lock-and-blur.sh
  ;;
*)
  systemctl "$choice"
  ;;
esac
