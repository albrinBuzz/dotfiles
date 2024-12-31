#!/bin/bash

# Menú emergente con Zenity
opcion=$(zenity --list --title "cambio de tema" --column "Opción" \
"Rainbow" \
"Degrade" \
"Opción 3")

# Verificar la opción seleccionada
case $opcion in
    "Opción 1") echo "Seleccionaste la Opción 1";;
    "Degrade") ~/.config/polybar/degrade/launch.sh &;;
    "Opción 3") echo "Seleccionaste la Opción 3";;
    *) echo "Opción no válida";;
esac
