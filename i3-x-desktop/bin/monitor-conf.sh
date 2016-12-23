#!/bin/sh

internal="LVDS1"
hdmi="HDMI1"
vga="VGA1"

function is_connected {
    local display=$1
    if [ "$(xrandr --query | grep "$display connected")" == "" ]; then
        return 1
    else
        return 0
    fi
}

displays=""
if is_connected $hdmi; then
    displays+=" --output $hdmi --primary --auto --above $internal"
else
    displays+=" --output $hdmi --off"
fi

if is_connected $vga; then
    if ! is_connected $hdmi; then
        displays+=" --output $vga --primary --auto --above $internal"
    else
        displays+=" --output $vga --auto --left-of $hdmi"
    fi
else
    displays+=" --output $vga --off"
fi

if is_connected $hdmi || is_connected $vga; then
    displays+=" --output $internal --auto"
else
    displays+=" --output $internal --primary --auto"
fi

xrandr $displays
