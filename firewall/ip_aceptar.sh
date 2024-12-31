
#!/bin/bash


iptables -t filter -F
iptables -t nat -F 
iptables -t filter -Z
iptables -t nat -Z 

 sudo iptables -P INPUT  ACCEPT
 sudo iptables -P OUTPUT ACCEPT
 sudo iptables -P FORWARS ACCEPT
