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
BACKUP_DATE="$(date +%Y-%m-%d_%H%M)"
BASE_BACKUP_PATH="{{ nextcloud_backup_path }}"
CURRENT_BACKUP_PATH="${BASE_BACKUP_PATH}/${BACKUP_DATE}"

MESSAGE_PREFIX="[Nextcloud Backup]"



#
# Functions
#

# shellcheck source=/dev/null
. "${REPO_BASE_PATH}/utils/logging.sh"

# shellcheck source=/dev/null
. "${REPO_BASE_PATH}/utils/notifications.sh"



backup_app() {
    pushd "$PROJECT_PATH" > /dev/null || exit
        info "$MESSAGE_PREFIX" "Stopping the docker container first ..."
        docker-compose stop

        info "$MESSAGE_PREFIX" "Packageing all data into one giant tar.gz archive ..."
        tar --create \
            --gzip   \
            --file "${CURRENT_BACKUP_PATH}/nextcloud_backup.tar.gz" \
            "./"

        info "$MESSAGE_PREFIX" "Copying the docker-compose.yml as a plain file for reference ..."
        cp docker-compose.yml "${CURRENT_BACKUP_PATH}"

        info "$MESSAGE_PREFIX" "Putting the restore script as a plain file for convience ..."
        cp restore.sh "${CURRENT_BACKUP_PATH}"
    popd > /dev/null || return
}

write_latest_backup_date() {
    echo "$BACKUP_DATE" > "${BASE_BACKUP_PATH}/latest.env"
}


#
# MAIN
#

print_header "Creating a Nextcloud backup !" "The backup will be stored at ${CURRENT_BACKUP_PATH}"
send_notification "${MESSAGE_PREFIX}" "Starting the local backup process!"
backup_app
write_latest_backup_date
send_notification "${MESSAGE_PREFIX}" "Local backup finished successfully."