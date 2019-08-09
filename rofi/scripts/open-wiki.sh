#! /usr/bin/env sh

prefix=$HOME/Documents/iteratec/Notes
markdown_files=( "$prefix"/**/*.md )
markdown_files=( "${markdown_files[@]#"$prefix"/}" )
markdown_files=( "index" "${markdown_files[@]%.md}" )

selection=$(printf '%s\n' "${markdown_files[@]}" | rofi -dmenu -p "Select entry")

if [ -n "$selection" ]
then
        terminology --exec vim "$prefix/${selection}.md"
fi
