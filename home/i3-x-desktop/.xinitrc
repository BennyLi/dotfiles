eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
eval $(ssh-agent)

PATH="$PATH:$HOME/bin"

setxkbmap de
exec i3
