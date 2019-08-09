#! /usr/bin/env sh

selection=$(cat ~/.config/qutebrowser/quickmarks | rofi -dmenu -p "Select a bookmark")

test -n "$selection" || exit 1

# See http://mywiki.wooledge.org/BashFAQ/100#Extracting_parts_of_strings
name="${selection% *}" # Remove everything after the last whitespace
url="${selection##* }" # Remove everything before the last whitespace
echo "Name: $name"
echo "Url: $url"

qutebrowser --target window $url
