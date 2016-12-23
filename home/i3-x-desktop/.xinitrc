eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
eval $(ssh-agent)

PATH="$PATH:$HOME/bin"

exec i3
