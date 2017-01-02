#!/bin/sh

sudo pacman -S lxappearance arc-gtk-theme

yaourt -S i3blocks acpi bc sysstat


# Icon Theme
cd /tmp
git clone https://github.com/erikdubois/Super-Ultra-Flat-Numix-Remix
cp Super-Ultra-Flat-Numix-Remix/Surfn\ Arc ~/.icons/
rm -rf /tmp/Super-Ultra-Flat-Numix-Remix


# Fonts
yaourt -S system-san-francisco-font-git ttf-material-design-icons-git

# Using MaterialDesignIcons (see above)
#cd /tmp
#git clone https://github.com/FortAwesome/Font-Awesome
#sudo cp Font-Awesome/fonts/fontawesome-webfont.ttf /usr/share/fonts/TTF/
#rm -rf Font-Awesome


# Transition effect
sudo pacman -S compton
