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



#sudo iptables -A OUTPUT -o nm-bridge -p udp --dport 39658   -j ACCEPT 
#sudo iptables -A INPUT -i nm-bridge -p udp --sport 39658   -j ACCEPT 

#sudo iptables -A OUTPUT -o nm-bridge -p udp --dport 54055    -j ACCEPT 
#sudo iptables -A INPUT -i nm-bridge -p udp --sport 54055    -j ACCEPT 

#sudo iptables -I FORWARD -i virbr0 -o virbr0 -j ACCEPT


#sudo iptables -I INPUT 1 -i lo -j ACCEPT 

#sudo iptables -I OUTPUT 1 -o lo -j ACCEPT 

sudo iptables -A OUTPUT -o nm-bridge -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -i nm-bridge -p tcp --sport 80 -j ACCEPT

sudo iptables -A OUTPUT -o nm-bridge -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -i nm-bridge -p tcp --sport 443 -j ACCEPT


##sudo iptables -A OUTPUT -p tcp --dport 1194 -j ACCEPT
#sudo iptables -A INPUT -p tcp --sport 1194 -j ACCEPT

#sudo iptables -A INPUT -p udp -m udp --sport 1194 -j ACCEPT

#sudo iptables -A OUTPUT -p udp -m udp --dport 1194 -j ACCEPT

#sudo iptables -A INPUT -p tcp -m tcp --dport 1521 -s 192.168.122.147 -j ACCEPT
#sudo iptables -A OUTPUT -p tcp -m tcp --sport 1521 -s 192.168.122.147 -j ACCEPT

sudo iptables -A OUTPUT -p tcp -m tcp --dport 1521 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --sport 1521 -j ACCEPT

#sudo iptables -A OUTPUT -p tcp -m tcp --dport 6463  -j ACCEPT
#sudo iptables -A INPUT -p tcp -m tcp --sport 6463  -j ACCEPT

#sudo iptables -A INPUT -s 192.168.122.125 -i enp1s0 -j ACCEPT

#sudo iptables -A INPUT -s 192.168.122.125 -j ACCEPT
#sudo iptables -A  OUTPUT  -s 192.168.122.125 -j ACCEPT

sudo iptables-save   &
#sudo systemctl start --now iptables.service
#sudo iptables -A INPUT -p tcp --dport 1521 -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --sport 1521 -j ACCEPT



