#! /usr/bin/env sh

selection=$(sqlite3 $HOME/.local/share/qutebrowser/history.sqlite "select url from history;" | uniq | rofi -dmenu -p "Enter URL")

if [ -n "$selection" ]
then
  qutebrowser --target=window "$selection"
fi
