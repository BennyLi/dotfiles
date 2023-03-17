#! /usr/bin/env bash

send_notification() {
    local title="$1"
    local message="$2"

    curl -X POST "https://{{ gotify_domain }}/message?token={{ gotify_app_token }}" \
         -F "title={{ $title }}" \
         -F "message={{ $message }}"
}