#!/bin/bash

iptables -t filter -F
iptables -t nat -F
iptables -t filter -Z
iptables -t nat -Z

# Establecer políticas predeterminadas
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A OUTPUT -o $interfaz -p udp --dport 50000:65535  -j ACCEPT
iptables -A INPUT -i $interfaz -p udp --sport 50000:65535  -j ACCEPT

# Permitir tráfico HTTP y HTTPS saliente
iptables -A OUTPUT -o $interfaz -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -o $interfaz -p tcp --dport 443 -j ACCEPT

# Permitir tráfico HTTP y HTTPS entrante para conexiones establecidas
iptables -A INPUT -i $interfaz -p tcp --sport 80 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i $interfaz -p tcp --sport 443 -m state --state ESTABLISHED,RELATED -j ACCEPT
#iptables -A INPUT -p tcp --dport 6457:6463 -j ACCEPT
iptables -A OUTPUT -o $interfaz -p tcp --dport 6457:6463 -j ACCEPT
iptables -A INPUT -i $interfaz -p tcp --sport 6457:6463 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables-save