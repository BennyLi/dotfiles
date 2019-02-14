#! /usr/bin/env sh

selection=$(ls -p /etc/netctl | grep -v / | rofi -dmenu -p "Select network profile")

sudo netctl start $selection
