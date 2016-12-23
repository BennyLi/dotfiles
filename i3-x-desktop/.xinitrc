eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

PATH="$PATH:$HOME/bin"
#export PATH

exec i3
