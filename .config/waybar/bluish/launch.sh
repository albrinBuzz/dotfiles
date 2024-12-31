#!/usr/bin/env sh

# Terminate already running bar instances
#killall -q waybar

# Wait until the processes have been shut down
#while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main
#waybar

# Ruta al directorio donde tienes los estilos y configuraciones
CONFIG_DIR="$HOME/.config/waybar/bluish"

# Nombre del archivo de configuración y de estilo que deseas utilizar
CONFIG_FILE="config.json"
STYLE_FILE="style.css"

# Termina cualquier instancia de Waybar que esté ejecutándose
killall -q waybar

# Espera hasta que todos los procesos de Waybar se hayan cerrado
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done

# Lanza Waybar con el archivo de configuración y estilo especificado



