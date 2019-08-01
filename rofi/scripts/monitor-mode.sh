#!/bin/bash

selection=$(xrandr --listactivemonitors | grep -v Monitors | sed -nr 's/.*\s([a-zA-Z0-9\-]*)$/\1/p' | sort | rofi -dmenu -i -p "Move workspace to monitor")

if [ -n "$selection" ]
then
  i3-msg "move workspace to output $selection" > /dev/null
  i3-msg "focus output $selection" > /dev/null
fi
