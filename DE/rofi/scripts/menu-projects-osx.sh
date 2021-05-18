#!/bin/bash

set -u

readonly PROJECTS_DIR=~/.vim/temp_dirs/sessions/

if [[ ! -a "${PROJECTS_DIR}" ]]; then
    echo "empty" >> "${PROJECTS_DIR}"
fi

function get_projects()
{
    projects=$(ls -c ${PROJECTS_DIR} )
    projects=${projects//%/\/}
    projects=${projects// / }
    echo "$projects"
}

function main()
{
    project="$(get_projects 2> /dev/null | choose)"
    rofi_exit=$?

    if [[ $rofi_exit -eq 1 ]]; then
        exit
    else
        kitty -1 -d ${project} sh -c "sleep 0.1; nvim"
        #./iterm.sh "${project}" "sh -c 'sleep 0.1'; vim"
    fi
}

main
