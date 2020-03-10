#!/bin/bash

if [ ! -e /tmp/i3lock.png ]; then
  ACTIVE_MONITORS=$(xrandr --listactivemonitors | grep -v Monitors | sed -nr 's/.*\s([a-zA-Z0-9\-]*)$/\1/p' | sort)
  echo "Active Monitors: ${ACTIVE_MONITORS}"

  monitor_index=0
  while read -r monitor; do
    i3-msg focus output ${monitor}
    i3-msg workspace _${monitor_index}

    monitor_index=$((monitor_index+1))
  done <<< "${ACTIVE_MONITORS}"

  maim --window=root --hidecursor --delay 2 | convert - -blur 0x3 /tmp/i3lock.png
fi

i3lock --show-failed-attempts --image=/tmp/i3lock.png
