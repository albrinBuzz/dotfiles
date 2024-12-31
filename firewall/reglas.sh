#!/bin/bash

   
sudo iptables -t filter -F
sudo iptables -t nat -F 
sudo iptables -t filter -Z
sudo iptables -t nat -Z 

 sudo iptables -P INPUT DROP
 sudo iptables -P OUTPUT DROP
 sudo iptables -P FORWARD DROP 



sudo iptables -A OUTPUT -o nm-bridge -p udp --dport 53 -j ACCEPT 
sudo iptables -A INPUT -i nm-bridge -p udp --sport 53 -j ACCEPT 



sudo iptables -A OUTPUT -o nm-bridge -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -i nm-bridge -p tcp --sport 80 -j ACCEPT


sudo iptables -A OUTPUT -o nm-bridge -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -i nm-bridge -p tcp --sport 443 -j ACCEPT


sudo iptables-save   &
sudo systemctl start --now iptables.service