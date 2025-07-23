#!/bin/bash
# https://github.com/polybar/polybar/issues/763#issuecomment-331604987
killall polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload -c ~/.config/polybar/config.ini example &
  done
else
  polybar --reload -c ~/.config/polybar/config.ini example &
fi
