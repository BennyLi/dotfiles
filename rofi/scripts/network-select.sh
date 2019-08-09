#! /usr/bin/env sh

selection=$(ls -p /etc/netctl | grep -v / | rofi -dmenu -p "Select network profile")

test -n "$selection" || exit 1

sudo netctl stop-all
sudo netctl start $selection
