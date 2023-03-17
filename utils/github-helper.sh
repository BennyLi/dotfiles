#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -o posix     # enforce more compatibility to non-bash shells
#set -o xtrace    # debug mode

# source: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
github_get_current_release_version() {
  local github_repo="$1"

  curl --silent "https://api.github.com/repos/${github_repo}/releases/latest" \
   | grep '"tag_name":'                                                       \
   | sed -E 's/.*"([^"]+)".*/\1/'
}