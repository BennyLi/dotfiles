#! /usr/bin/env sh

# Open a saved qutebrowser session
# OR if non efound by this name, start qutebrowser with this new session :D

selection=$(ls ~/.local/share/qutebrowser/sessions | grep --invert-match '^_' | sed -r 's/.yml$//' | rofi -dmenu -p "Select a web session name" )

test -n "$selection" || exit 1

if [ -f ~/.local/share/qutebrowser/sessions/$selection.yml ]
then
#  qutebrowser --target window
#  sleep 1s
  qutebrowser :"session-load $selection" #:q # quit the temporary window
else
  qutebrowser --target window
  sleep 1s
  qutebrowser :"session-save --only-active-window $selection"
fi
