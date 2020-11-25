#!/bin/bash

echo "=====================================" 
echo "   = = = = = =        = = = = = =   " 
echo "====================================="
echo "Scan all ports, and enumerate using some tools"
echo "=====================================" 
echo "   = = = = = =        = = = = = =   " 
echo "====================================="
echo " "
#niktoused actually means unused lol
niktoused=true
if [ -z "$1" ] 
then
	read -p "Enter remote host ip:" ip
	nmap -T4 -p- "$ip" | grep open |  cut -d "/" -f1 | while read -r line ; do
		echo "Port $line"

		#nmap -T4 -p $line $ip -A
	done
#nikto scans if webports open
	if [ "$line" = *"80"* ] && [ $niktoused ]
	then
		echo "Starting nikto scan..."
		nikto -h "$ip"
		niktoused=false
	fi

	if [ "$line" = *"443"* ]   && [ $niktoused ]
	then
		echo "Starting nikto scan..."
		nikto -h "$ip"
		niktoused=false
	fi

else 
	nmap -T4 -p- "$1" | grep open |  cut -d "/" -f1 | while read -r line ; do
		echo "Port $line"

		nmap -T4 -p "$line" "$1" #-A
	done

	if [ $line=="80" ]
	then
		echo "Starting nikto scan..."
		nikto -h "$1"
		niktoused=false
	fi

	if [ "$line" = "443" ]   && [ $niktoused ]
	then
		echo "Starting nikto scan..."
		nikto -h "$1"
		niktoused=false
	fi
fi
