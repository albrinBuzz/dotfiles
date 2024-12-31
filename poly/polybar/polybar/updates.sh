#!/bin/bash

echo
echo 'updates.sh: "dnf check-update"'
echo
dnf check-update
echo
bash ~/.config/polybar/checkupdates.sh

read -p "Press enter to close this window..."
