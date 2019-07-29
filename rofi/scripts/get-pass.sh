#! /usr/bin/env sh

# see https://git.zx2c4.com/password-store/tree/contrib/dmenu/passmenu
prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

selection=$(printf '%s\n' "${password_files[@]}" | rofi -dmenu -p "Select entry")

if [ -n "$selection" ]
then
        pass show -c "$selection" 2>/dev/null
fi
