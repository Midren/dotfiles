#!/bin/bash

set -u

readonly PROJECTS_DIR=~/.vim/temp_dirs/sessions/

if [[ ! -a "${PROJECTS_DIR}" ]]; then
    echo "empty" >> "${PROJECTS_DIR}"
fi

function get_projects()
{
    projects=$(ls -cx ${PROJECTS_DIR} )
    projects=${projects//%/\/}
    projects=${projects// / }
    echo "$projects"
}

function main()
{
    project="$(get_projects 2> /dev/null | rofi -kb-custom-1 "Ctrl+o" -dmenu -p "Project:")"
    rofi_exit=$?

    if [[ $rofi_exit -eq 1 ]]; then
        exit
    elif [[ $rofi_exit -eq 10 ]]; then
        cd "${project}" && st
    elif [[ $rofi_exit -eq 0 ]]; then
        export LC_ALL=en_US.UTF-8
        cd "${project}" && st -e vim
    fi
}

main
