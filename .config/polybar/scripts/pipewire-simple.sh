#!/bin/sh

getDefaultSink() {
lines=$(pactl list sinks | grep "${defaultSink}")
description=$(echo "$lines" | sed -n '/Description:/s/^\s*Description: \(.*\)/\1/p')
    echo "${description}"
}

getDefaultSource() {
lines=$(pactl list sinks | grep "${defaultSink}")
description=$(echo "$lines" | sed -n '/Description:/s/^\s*Description: \(.*\)/\1/p')
    echo "${description}"
}



if [ $(pamixer --get-mute) == "false" ]; then
  VOLUME=$(pamixer --get-volume-human)
else
  VOLUME="mueteado"
fi


SINK=$(getDefaultSink)
SOURCE=$(getDefaultSource)

case $1 in
    "--up")
        pamixer --increase 5
        ;;
    "--down")
        pamixer --decrease 5
        ;;
    "--mute")
        pamixer --toggle-mute
        
        ;;
    *)
        #echo "Source: ${SOURCE} | Sink: ${VOLUME} ${SINK}"
        echo "${VOLUME} ${SINK}"
esac