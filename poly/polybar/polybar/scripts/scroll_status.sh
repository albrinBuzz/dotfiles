 #!/bin/bash

cmd="${0%/*}/get_status.sh $1"

zscroll -l 20 \
    --scroll-padding "$(printf ' %.0s' {1..8})" \
    -d 0.60 \
    -M "$cmd icon" \
    -m "none"       "-b ''" \
    -m "browser"    "-b ' '" \
    -m "netflix"    "-b 'ﱄ '" \
    -m "youtube"    "-b ' '" \
    -m "prime"      "-b ' '" \
    -m "spotify"    "-b ' '" \
    -m "vlc"        "-b '嗢 '" \
    -m "mpv"        "-b ' '" \
    -m "kdeconnect" "-b ' '" \
    -m "corridor"   "-b ' '" \
    -U 1 -u t "$cmd" &

wait

Footer
