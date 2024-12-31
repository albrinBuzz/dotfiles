#!/bin/bash 
 nft flush table filter
 nft flush table
 # Delete all chains in the filter and nat tables
 nft delete chain filter input
 nft delete chain filter output
 nft delete chain filter forward
 nft delete chain nat pre-routing
 nft delete chain nat postrou
 # Set default policies for all three chains to DROP
 nft policy filter input drop
 nft policy filter output drop
 nft policy filter forward drop
 nft policy nat pre-routing drop
 nft policy nat postrouting 
 # Allow outgoing DNS traffic (UDP port 53)
 nft rule add chain filter output oifname nm-bridge protocol udp dport 53 ac
 # Allow incoming DNS responses (UDP port 53)
 nft rule add chain filter input ifname nm-bridge protocol udp sport 53 ac
 # Allow outgoing HTTP traffic (TCP port 80)
 nft rule add chain filter output oifname nm-bridge protocol tcp dport 80 ac
 # Allow incoming HTTP responses (TCP port 80)
 nft rule add chain filter input ifname nm-bridge protocol tcp sport 80 ac
 # Allow outgoing HTTPS traffic (TCP port 443)
 nft rule add chain filter output oifname nm-bridge protocol tcp dport 443 ac
 # Allow incoming HTTPS responses (TCP port 443)
 nft rule add chain filter input ifname nm-bridge protocol tcp sport 443 accept