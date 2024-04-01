#!/bin/bash

while getopts "da" opt; do
  case ${opt} in
    d )
      echo "Dropping iptables protection" 
      iptables -D  INPUT -p tcp -s 0.0.0.0/0 --dport 22 -j DROP
      iptables -D  INPUT -p tcp -s 0.0.0.0/0 --dport 111 -j DROP
      ;;
    a )
      echo "Adding iptables protection"
      iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 22 -j DROP
      iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 111 -j DROP
      ;;
    \? )
      echo "No argument given, no iptables action taken"
  esac
done

iptables -L INPUT
