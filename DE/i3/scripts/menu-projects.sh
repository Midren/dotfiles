#!/bin/bash

set -u
set -e

readonly PROJECTS_DIR=~/.vim/temp_dirs/sessions/

if [[ ! -a "${PROJECTS_DIR}" ]]; then
    echo "empty" >> "${PROJECTS_DIR}"
fi

function get_projects()
{
    ls -c ${PROJECTS_DIR}
}

function main()
{
    local all_projects="$(get_projects)"

    local project=$( (echo "${all_projects}")  | rofi -dmenu -p "Project:")
    local matching=$( (echo "${all_projects}") | grep "^${project}$")

    if [[ -n "${matching}" ]]; then
        echo $(echo ${matching} | tr % /)
        cd $(echo ${matching} | tr % /) && st -e vim
    fi
}

main
