#!/bin/bash

set -u
set -e

readonly NOTES_DIR=~/Documents/Notes

if [[ ! -a "${NOTES_DIR}" ]]; then
    echo "empty" >> "${NOTES_DIR}"
fi

function get_notes()
{
    ls ${NOTES_DIR}
}

function main()
{
    local all_notes="$(get_notes)"

    local note=$( (echo "${all_notes}")  | rofi -dmenu -p "Note:")
    local matching=$( (echo "${all_notes}") | grep "^${note}$")

    if [[ -n "${matching}" ]]; then
        st -e vim "$NOTES_DIR/${matching}"
    else
        if [[ -n "${note}" ]]; then
            st -e vim +"edit note:${note}"
        fi
    fi
}

main