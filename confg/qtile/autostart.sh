#!/bin/sh

xrandr --output HDMI-1-2 --mode 1366x768 --pos 0x0 --output eDP-1  --auto --pos 1366x0 &

picom &

polybar &
~/.config/polybar/launch.sh  --shapes &
picom --config /home/cris/.config/picom/picom.conf &

nitrogen --restore &

feh --bg-fill --randomize /home/cris/Imagenes  

