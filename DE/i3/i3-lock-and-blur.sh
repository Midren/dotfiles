#!/usr/bin/env bash

# set the icon and a temporary location for the screenshot to be stored
icon="$HOME/.config/i3/lock_screen.png"
tmpbg='/tmp/screen.png'

SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
I=0
for RES in $SR; do
    SRA=(${RES//[x+]/ })
    WIDTH=${SRA[0]}
    HEIGHT=${SRA[1]}
    rectangle="rectangle $((WIDTH*58/100-86)),$(($HEIGHT*55/100-52)) $((WIDTH*58/100+86)),$((HEIGHT*55/100+52))"
    if [ $I -ge 1 ]; then
        flameshot screen -r -n $I | \
            convert - -draw "fill black fill-opacity 0.4 $rectangle" \
            -filter Gaussian -thumbnail 20% -sample 500% \
            "$icon" -gravity center -composite - | \
            convert - "$tmpbg" +append "$tmpbg"
    else

        if [[ ${#SR[@]} -eq 1 ]]; then
            flameshot full -r | convert - -draw "fill black fill-opacity 0.4 $rectangle" \
                -filter Gaussian -thumbnail 20% -sample 500% \
                "$icon" -gravity center -composite "$tmpbg"
        else
            flameshot screen -r -n $I | convert - -draw "fill black fill-opacity 0.4 $rectangle" \
                -filter Gaussian -thumbnail 20% -sample 500% \
                "$icon" -gravity center -composite "$tmpbg"
        fi
    fi
    I=$((I+1))
done

# It is actually using i3lock
i3lock -ei "$tmpbg" -f \
     -k --pass-media-keys --pass-screen-keys --indpos='x+0.58*w:y+0.55*h' --datecolor=FFFFFFFF --timecolor=FFFFFFFF --wrongcolor=FFFFFFFF --verifcolor=FFFFFFFF
sleep 3
xset dpms force off
