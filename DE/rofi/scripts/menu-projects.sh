#!/bin/bash

set -u

readonly PROJECTS_DIR=~/.vim/temp_dirs/sessions/

if [[ ! -a "${PROJECTS_DIR}" ]]; then
    echo "empty" >> "${PROJECTS_DIR}"
fi

function get_projects()
{
    projects=$(ls -c ${PROJECTS_DIR})
    projects=${projects//%/\/}
    echo $projects
}

function main()
{
    project="$(get_projects 2> /dev/null | rofi -kb-custom-1 "Ctrl+o" -dmenu -p "Project:" -sep " ")"
    rofi_exit=$?

    if [[ $rofi_exit -eq 1 ]]; then
        exit
    elif [[ $rofi_exit -eq 10 ]]; then
        cd $(echo ${project} | tr % / ) && st
    elif [[ $rofi_exit -eq 0 ]]; then
        export LC_ALL=en_US.UTF-8
        cd $(echo ${project} | tr % /) && st -e vim
    fi
}

main
