
#!/bin/bash

# Directorio con tus fondos de pantalla
FONDO_DIR="$HOME/Imagenes"
n_monitores=$(xrandr --query | grep "connected" | grep -v "disconnected")
monitor_aletaorio1=$(ls -1 |  xrandr --query | grep "connected" | grep -v "disconnected" | sort -R | head -n 1 | awk '{print $1}'  )
monitor_aletaorio2=$(ls -1 |  xrandr --query | grep "connected" | grep -v "disconnected" | sort -R | head -n 1 | awk '{print $1}'  )
# Selecciona un archivo aleatorio del directorio

FONDO_ALEATORIO1=$(ls -1 "$HOME/Imagenes" | sort -R | head -n 1 )
FONDO_ALEATORIO2=$(ls -1 "$HOME/Imagenes" | sort -R | head -n 1 )


#feh --bg-scale "$FONDO_DIR/$FONDO_ALEATORIO1" --output "$monitor_aleatorio1"
#feh --bg-scale "$FONDO_DIR/$FONDO_ALEATORIO2" --output "$monitor_aleatorio2"

feh --bg-fill -z ~/Imagenes/*




