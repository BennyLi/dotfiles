#!/bin/sh
if [ $# -ne 1 ]; then
  echo "Usage: $0 folder-name"
  exit 1
fi

stow -R -v 3 -t ~/ $1
