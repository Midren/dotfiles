#!/bin/bash

set -u
set -e

readonly NOTES_DIR=~/Documents/Notes

if [[ ! -a "${NOTES_DIR}" ]]; then
    echo "empty" >> "${NOTES_DIR}"
fi

function get_notes()
{
    ls -c ${NOTES_DIR}
}

function main()
{
    local all_notes="$(get_notes)"

    local note=$( (echo "${all_notes}")  | rofi -dmenu -p "Note:")
    local matching=$( (echo "${all_notes}") | grep "^${note}$")

    if [[ -n "${matching}" ]]; then
        PROGRAM="alacritty -e vim +Goyo \"$NOTES_DIR/${matching}\""
    else
        if [[ -n "${note}" ]]; then
            PROGRAM="alacritty -e vim +edit +Goyo \"$NOTES_DIR/${note}.md\""
        else
            exit 1
        fi
    fi
    echo $PROGRAM
    ~/.config/i3/i3-run-floating.sh "$PROGRAM"
}

main
