#!/bin/bash

sudo  iptables -t filter -F
sudo iptables -t nat -F 
sudo iptables -t filter -Z
sudo iptables -t nat -Z 

 sudo iptables -P INPUT DROP
 sudo iptables -P OUTPUT DROP
 sudo iptables -P FORWARD DROP   
