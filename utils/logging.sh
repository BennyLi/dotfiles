#! /usr/bin/env bash

print_header() {
    local title="$1"
    local optional_message="${2:-}"

    echo "################################################################################"
    echo "#"
    echo "# $title"
    echo "#"
    echo "################################################################################"
    echo ""

    if [ -n "$optional_message" ]
    then
        echo "$optional_message"
    fi
}

info() { 
    local message_prefix="$1"
    local message="$2"

    echo "${message_prefix} ($(data +%Y-%m-%d %H:%m))  $message"
}