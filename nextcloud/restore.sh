#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -o posix     # enforce more compatibility to non-bash shells
#set -o xtrace    # debug mode

#
# Variables
#

PROJECT_PATH="{{ nextcloud_project_path }}"
BASE_BACKUP_PATH="{{ nextcloud_backup_path }}"

MESSAGE_PREFIX="[Nextcloud Backup Restore]"



#
# Functions
#

# shellcheck source=/dev/null
. "${REPO_BASE_PATH}/utils/logging.sh"



get_latest_backup_path() {
    echo "${BASE_BACKUP_PATH}/$(cut "${BASE_BACKUP_PATH}/latest.env")"
}

restore_stack() {
    # TODO
}