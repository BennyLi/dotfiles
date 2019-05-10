#! /usr/bin/env sh

#selection=$(systemd-mount --list | rofi -dmenu -p "Select device to mount")
selection=$(lsblk -rno NAME,LABEL,UUID,SIZE,HOTPLUG | grep '1$' | awk -F'[ ]' '$3!="" {print}' | rofi -dmenu -p "Select device to mount")

device=$(echo $selection | awk -F'[ ]' '{print $1}')
label=$(echo $selection | awk -F'[ ]' '{print $2}')
uuid=$(echo $selection | awk -F'[ ]' '{print $3}')
mountpoint=/run/media/$USER/${label:-$device}_$uuid
#echo $device
#echo $label
#echo $mountpoint

mount --source UUID=$uuid --target $mountpoint
#systemd-mount --user --collect $device
