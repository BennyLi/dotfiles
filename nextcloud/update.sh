#! /usr/bin/env bash

################################################################################
#
# Nextcloud Docker Update Helper
#
# This script should never be run by a task scheduler like cron.
# It should always be run by hand, to handle issue with the instance.
#
################################################################################

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -o posix     # enforce more compatibility to non-bash shells
#set -o xtrace    # debug mode

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_BASE_PATH="${SCRIPT_DIR}/.."



#
# Variables
#

PROJECT_PATH="{{ nextcloud_project_path }}"
BACKUP_DATE="$(date +%Y-%m-%d_%H%M)"
BASE_BACKUP_PATH="{{ psono_backup_path }}"

MESSAGE_PREFIX="[Nextcloud Backup]"



#
# Functions
#

# shellcheck source=/dev/null
. "${REPO_BASE_PATH}/utils/github-helper.sh"

# shellcheck source=/dev/null
. "${REPO_BASE_PATH}/utils/logging.sh"

# shellcheck source=/dev/null
. "${REPO_BASE_PATH}/utils/notifications.sh"

should_update() {
    local current_local_version
    current_local_version="$(cat "${PROJECT_PATH}/version.env")"
    local current_release_version
    current_release_version="$(github_get_current_release_version "nextcloud/server")"

    if [ "$current_local_version" \< "$current_release_version" ]
    then
        local do_update="n"
        info "$MESSAGE_PREFIX" "Update available [${current_local_version}] > [${current_release_version}]"
        info "$MESSAGE_PREFIX" "Ensure you created a backup first!"
        read -r -p "Proceed? [y/N] " do_update

        if [ "$do_update" == "y" ] || [ "$do_update" == "Y" ]
        then
            echo "yes"
            return
        fi
    fi

    echo "no"
}

update_nextcloud_version_number() {
    local current_local_version
    current_local_version="$(cat "${PROJECT_PATH}/version.env")"
    local current_release_version
    current_release_version="$(github_get_current_release_version "nextcloud/server")"

    info "$MESSAGE_PREFIX" "Updating Nextcloud version inside the docker-compose.yml file."
    sed --in-place "s/nextcloud:${current_local_version#v}/nextcloud:${current_release_version#v}/g" "${PROJECT_PATH}/docker-compose.yml"

    info "$MESSAGE_PREFIX" "Updating Nextcloud version inside the version.env file."
    echo "$current_release_version" > "${PROJECT_PATH}/version.env"
}

update_stack() {
    info "$MESSAGE_PREFIX" "Stopping and removing the current Docker containers."
    docker-compose stop -f "${PROJECT_PATH}/docker-compose.yml"
    docker-compose rm -f "${PROJECT_PATH}/docker-compose.yml"

    update_nextcloud_version_number
    # TODO: 
    #   update_mariadb_version_number
    #   run_mariadb_migrations

    info "$MESSAGE_PREFIX" "Starting the Nextcloud stack again."
    docker-compose up --pull always --detach "${PROJECT_PATH}/docker-compose.yml"
}



#
# Main
#

print_header "Nextcloud update"
info "$MESSAGE_PREFIX" "Starting Nextcloud update process."

if [ "$(should_update)" == "yes" ]
then
    update_stack
    info "$MESSAGE_PREFIX" "Updates finished."
    info "$MESSAGE_PREFIX" "Do not forget to update your Ansible config values to match the new version!"
else
    info "$MESSAGE_PREFIX" "No updates applied."
fi
