#!/bin/bash

# Enter IP(s) to add to the iptable INPUTS table

# Usage: ./add_ip.sh <IP_1> <IP_2> ... <IP_N>

# Show current IP INPUT chain
printf "Current IP INPUT chain:\n"
iptables -L INPUT

# Delete drop rules
iptables -D INPUT -p tcp -s 0.0.0.0/0 --dport 111 -j DROP
iptables -D INPUT -p tcp -s 0.0.0.0/0 --dport 22 -j DROP

# Add new IPs
for IP_ADDRESS in $@
do
        printf "\nAdding $IP_ADDRESS to INPUT chain\n"
        iptables -A INPUT -p tcp -s $IP_ADDRESS --dport 22 -j ACCEPT
done
# Re-add drop rules
iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 22 -j DROP
iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 111 -j DROP

# Show new IP INPUT chain
printf "\nNEW IP INPUT chain:\n" 
iptables -L INPUT 
