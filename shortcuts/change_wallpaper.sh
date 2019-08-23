#! /usr/bin/env bash

function get_random_file {
  echo "$1/$(ls $1 | sort -R | head -1)"
}

# Set background from different directory for up to 3 monitors
feh --bg-fill --no-fehbg \
        $(get_random_file ~/Pictures/Wallpaper/family) \
        $(get_random_file ~/Pictures/Wallpaper/urban) \
        $(get_random_file ~/Pictures/Wallpaper/nature) \

# Remove screen lock image, so a new one will be generated on the current setup
rm -f /tmp/i3lock.png

