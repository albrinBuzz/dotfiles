#!/bin/bash

# Obtener la interfaz de red por defecto
default_interface=$(ip route | grep '^default' | awk '{print $5}')

# Verificar que se obtuvo la interfaz de red por defecto
if [ -z "$default_interface" ]; then
  echo "No se pudo determinar la interfaz de red por defecto"
  exit 1
fi

echo "La interfaz de red por defecto es: $default_interface"
default_root=$(pwd)

# Generar el archivo de configuración de nftables

cat <<EOL > $default_root/reglas.nft
#!/usr/sbin/nft -f
#
############################################
# Script nft v1.0                          #
# José Luis Sánchez                        #
# https://www.mytcpip.com                  #
# Fichero: /root/fw/reglas.nft             #
#                                          #
# Definición script                        #
# =================                        #
# - Solo IPv4                              #
# - Política por defecto DROP              #
# - Permitir acceso ssh al servidor desde  #
#   cualquier máquina de la red local      #
# - Permitir tráfico udp de salida 53      #
# - Permitir tráfico tcp de salida 22,     #
#   80, 443                                #
#                                          #
# En todos los casos añadimos counter al   #
# final para saber el tráfico asociado a   #
# cada regla.                              #
#                                          #
# Ejecutar el script con la orden:         #
#                                          #
# nft -f nombredelscript                   #
#                                          #
############################################

# Declaramos variables que utilizamos en el script
#define udpSI = { 53 }
#define tcpSI = { 80, 443 } # Puertos seleccionados: 80 (HTTP), 443 (HTTPS)
#
## Borramos cualquier regla establecida en el sistema
#flush ruleset
#
# Declaramos la tabla "filtrado" asociada a la familia "ip"
# Por lo tanto estamos solo aplicando estas reglas a IPv4
add table ip filtrado

# Establecemos política por defecto DROP en las cadenas input, output y forward
# asociadas a la tabla filtrado
add chain ip filtrado INPUT   { type filter hook input priority 0; policy drop; }
add chain ip filtrado FORWARD { type filter hook forward priority 0; policy drop; }
add chain ip filtrado OUTPUT  { type filter hook output priority 0; policy drop; }

# Permitimos cualquier tipo de tráfico local loopback (nombre interface lo)
add rule ip filtrado INPUT iifname lo counter accept
add rule ip filtrado OUTPUT oifname lo counter accept

add rule ip filtrado OUTPUT udp dport $udpSI counter accept
add rule ip filtrado INPUT  udp sport $udpSI counter accept

# Permitimos todos los protocolos TCP definidos en la variable tcpSI

add rule ip filtrado OUTPUT tcp dport $tcpSI counter accept
add rule ip filtrado INPUT  tcp sport $tcpSI counter accept

# Añadimos counter al final de cada regla para saber el tráfico asociado a cada una
add rule ip filtrado INPUT counter
add rule ip filtrado FORWARD counter
add rule ip filtrado OUTPUT counter
EOL

# Ejecutar el script de nftables
nft -f $default_root/reglas.nft