#! /usr/bin/env sh

if [ -z $@ ]
then
  sqlite3 $HOME/.local/share/qutebrowser/history.sqlite "select url from history where url like '%duden.de%';" | uniq

else
  selection="$@"
  if [ -n "$selection" ]
  then
    if [[ $selection == https* ]]
    then
      # An entry from the history is selected
      qutebrowser --target=window "$selection" &
    else
      qutebrowser --target=window "https://www.duden.de/suchen/dudenonline/$selection" &
    fi
  fi
fi
