#!/bin/bash

#open_port=$(netstat -tln | awk '{print $4}' | tr -d "local" | tr -d "(ny" | sed 's/:/ /g' | awk '{print $2}' )
open_port=$(netstat -tln | awk '{print $4}' | tr -d "local" | tr -d "(ny" | sed 's/:/ /g' | awk '{print $2}' )
echo " puertos abiertos $open_port"

#!/bin/bash

# Obtiene una lista de todos los puertos abiertos
#ports=$(netstat -an | awk '{print $4}' | grep -v '^0$')

# Itera sobre la lista de puertos abiertos
#for port in $ports; do
  # Obtiene el PID del proceso que escucha en el puerto
 ## pid=$(lsof -n -i -P | grep $port | awk '{print $2}')

  # Imprime el puerto y el PID
  #echo "Puerto: $port, PID: $pid"
#done