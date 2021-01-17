#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo '"""""""""""""""""""""""""""""""""""""""""""""""""""""""'
    echo "| Custom_Scanner: Otty's Preferred Port Scanning Flow |"
    echo "|                                                     |"
    echo "| Usage: scan <ip_address>                            |"                          
    echo "|                                                     |"
    echo "| Run as sudo or root (uid 0) for fastest results.    |"  
    echo '"""""""""""""""""""""""""""""""""""""""""""""""""""""""'
    exit 1
fi

# set ip address
ip_address=$1

# identify open ports
echo "Enumerating ports. . . ."
echo " "
ports=$(nmap -T4 $ip_address -p- | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
echo "Done!"

# enumerate services on open ports
if [ $ports ]; then
    echo " "
    echo "Enumerating services on open ports. . . ."
    echo " " 
    results=$(nmap -A $ip_address -p$ports)
    echo "Done! Results: "
    echo "$results"
else
    echo "No open ports on host: $ip_address"
fi