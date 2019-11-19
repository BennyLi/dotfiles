#! /usr/bin/env sh

selection="$(sr -elvi | grep --invert-match '^ ' | sed --regexp-extended --quiet 's/(.*)\s+--.*/\1/p' | rofi -dmenu -p 'Search: ')"

test -z "$selection"

sr -browser=/usr/bin/firefox $selection
