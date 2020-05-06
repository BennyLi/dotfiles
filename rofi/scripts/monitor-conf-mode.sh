#! /usr/bin/env sh

HOOK_DIR=$HOME/.dotfiles/rofi/hooks


list_monitors()
{
  xrandr --current | sed -rn 's/^([a-zA-Z0-9\-]*)\sconnected.*$/\1/p' | sort
  xrandr --current | sed -rn 's/^([a-zA-Z0-9\-]*)\sdisconnected\s[0-9].*$/\1/p' | sort
}

list_connected_monitors()
{
  xrandr --listactivemonitors | grep -v Monitors | sed -nr 's/.*\s([a-zA-Z0-9\-]*)$/\1/p' | sort
}

is_monitor_connected()
{
  local monitor="$1"
  xrandr --current | sed -rn 's/^([a-zA-Z0-9\-]*)\sconnected.*$/\1/p' | grep "$monitor"
}

list_positioning_options()
{
  local monitor="$1"
  local monitor_is_connected="$(is_monitor_connected "$monitor")"

  if [ -n "$monitor_is_connected" ]
  then
    for connected_monitor in $(list_connected_monitors)
    do
      if [ "$connected_monitor" != "$monitor" ]
      then
        for rotation in normal inverted left right
        do
          echo $monitor left-of $connected_monitor rotate $rotation
          echo $monitor above $connected_monitor rotate $rotation
          echo $monitor right-of $connected_monitor rotate $rotation
          echo $monitor below $connected_monitor rotate $rotation
          echo $monitor same-as $connected_monitor rotate $rotation
        done
      fi
    done
  fi

  echo $monitor off
}

selected_monitor()
{
  echo $1 | sed -rn 's/^([a-zA-Z0-9\-]*)\s(left-of|above|right-of|below|same-as|off)\s?([a-zA-Z0-9\-]*)?\s?(rotate)?\s?(.*)$/\1/p'
}

selected_relative_monitor()
{
  echo $1 | sed -rn 's/^([a-zA-Z0-9\-]*)\s(left-of|above|right-of|below|same-as|off)\s?([a-zA-Z0-9\-]*)?\s?(rotate)?\s?(.*)$/\3/p'
}

selected_position()
{
  echo $1 | sed -rn 's/^([a-zA-Z0-9\-]*)\s(left-of|above|right-of|below|same-as|off)\s?([a-zA-Z0-9\-]*)?\s?(rotate)?\s?(.*)$/\2/p' 
}

selected_rotation()
{
  echo $1 | sed -rn 's/^([a-zA-Z0-9\-]*)\s(left-of|above|right-of|below|same-as|off)\s?([a-zA-Z0-9\-]*)?\s?(rotate)?\s?(.*)$/\5/p'
}

apply_configuration()
{
  local configuration="$1"
  local monitor=$(selected_monitor "$configuration")
  local relative_monitor=$(selected_relative_monitor "$configuration")
  local position=$(selected_position "$configuration")
  local rotation=$(selected_rotation "$configuration")

  if [ "off" = "$position" ]
  then
    xrandr --output $monitor --off
  else
    xrandr --output $monitor --scale 1x1 --auto --$position $relative_monitor --rotate $rotation
  fi

  sleep 1 # Wait for new conf to be applied or we will have some strange background issues
}

run_post_hooks()
{
  if [ -d $HOOK_DIR ]
  then
    for hook in $HOOK_DIR/*
    do
      echo "Executing hook $hook"
      $hook &>/dev/null
    done
  fi
}

selected_monitor=$(list_monitors | rofi -dmenu -i -p "Select a monitor")
if [ -z "$selected_monitor" ]
then
  echo "No monitor selected"
  exit
elif [ -z "$(list_monitors | grep $selected_monitor)" ]
then
  echo "Monitor '$selected_monitor' not found!"
  exit 1
fi
echo "Selected monitor: $selected_monitor"


selected_configuration=$(list_positioning_options "$selected_monitor" | rofi -dmenu -i -p "Select where the monitors position")
if [ -z "$selected_configuration" ]
then
  echo "No configuration selected!"
  exit 2
fi
echo "Selected configuration is $selected_configuration"

apply_configuration "$selected_configuration"
run_post_hooks
