#! /usr/bin/env sh

if [ -z $@ ]
then
  sqlite3 $HOME/.local/share/qutebrowser/history.sqlite "select url from history;" | uniq

else
  selection="$@"
  if [ -n "$selection" ]
  then
    qutebrowser --target=window "$selection"
  fi
fi
