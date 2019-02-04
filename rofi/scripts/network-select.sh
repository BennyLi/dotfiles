#! /usr/bin/env sh

selection=$(ls -p /etc/netctl | grep -v / | rofi -dmenu -mesg "Select network profile")

sudo netctl start $selection
