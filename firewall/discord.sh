#!/bin/bash
declare -i p1=45000
declare -i p2=65535
ap1=45000
ap2=65535
echo "[+] Opening ports between $p1 and $p2..."
for i in {45000..65535}
do
	sudo iptables -A OUTPUT -p udp --dport $i -j ACCEPT
	echo -n "Current port: $i"
	echo -en "\r"
done
echo "Ports $p1 - $p2 allowed outgoing."
#Port found in request packet. 
# Ctrl + Shift + I > Network > ?v=4:
# Look port
