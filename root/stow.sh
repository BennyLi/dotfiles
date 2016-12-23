#!/bin/sh
if [ $# -ne 1 ]; then
  echo "Usage: $0 folder-name"
  exit 1
fi

stow -S -v 3 -t / $1
if [ $? -eq 13 ]; then
  echo "Superuser privileges required!"
  sudo stow -S -v 3 -t / $1
fi
