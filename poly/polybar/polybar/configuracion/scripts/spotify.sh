#!/bin/bash

if [ "$(playerctl status >>/dev/null 2>&1; echo $?)" == "1" ]
then
	echo "spotify: Not Active"
	exit 0
fi

if [ "$(playerctl status)" == "Playing" ]
then
	title=$(playerctl metadata xesam:title)
	artist=$(playerctl metadata xesam:artist)
	echo ": $title | $artist"
else
	echo ": Music Stopped"
fi
