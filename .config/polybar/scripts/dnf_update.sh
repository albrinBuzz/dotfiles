#!/bin/sh




# Verifica la descarga de un archivo de Google


if wget -q -O /dev/null https://www.google.com; then
updates=$(dnf updateinfo -q --list | wc -l)
if [ "$updates" -gt 0 ]; then
    #echo "󰏖 $updates"
    echo " $updates"
else
    #echo "󱧖"
    echo "0"
fi
else
  exit 1;
fi

