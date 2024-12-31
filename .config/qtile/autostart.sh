#!/bin/sh

#xrandr --output HDMI-1-2 --mode 1366x768 --pos 0x0 --output eDP-1  --auto --pos 1366x0 &
#xrandr --output HDMI-1-2 --primary &

#xrandr --output HDMI-3 --mode 1366x768 --pos 0x0 --output DP-2   --auto --pos 1366x0 &
#xrandr --output DP-1 --primary --mode 1920x1080 --pos 0x0 --output HDMI-3 --mode 1366x768 --pos 1920x0 &
xrandr --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output HDMI-3 --mode 1920x1080 --pos 1920x0 --rotate normal &

#xrandr --output DP-2 --primary &
picom &

#polybar &
xscreensaver &
picom --config /home/cris/.config/picom/picom.conf &
~/.config/polybar/rainbow/launch.sh &
#/home/cris/.config/polybar/degrade/launch.sh &
nitrogen --restore &
/usr/libexec/polkit-gnome-authentication-agent-1 &  
#feh --bg-fill --randomize /home/cris/Imagenes  

