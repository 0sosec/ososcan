#!/bin/bash

echo "=====================================" 
echo "   = = = = = =        = = = = = =   " 
echo "====================================="
echo "Scan all ports, and enumerate using some tools"
echo "=====================================" 
echo "   = = = = = =        = = = = = =   " 
echo "====================================="
echo " "
if [ -z "$1" ] 
then
	read -p "Enter remote host ip:" ip
	nmap -T4 -p- "$ip" | grep open |  cut -d "/" -f1 | while read -r line ; do
		echo "Port $line"

		#nmap -T4 -p $line $ip -A
	done
#nikto scans if webports open
	if [ $line=="80" ]
	then
		echo "Starting nikto scan..."
		nikto -h "$ip"
	fi
#enum4linux for smb checks
	if [ $line=="139" ]
	then
		enum4linux "$ip"

	fi

	if [ $line=="443" ]
	then
		echo "Starting nikto scan..."
		nikto -h "https://$ip:443"

	fi

	if [ $line=="445" ]
	then
		enum4linux "$ip"

	fi	
	
else 
	nmap -T4 -p- "$1" | grep open |  cut -d "/" -f1 | while read -r line ; do
		echo "Port $line"

		nmap -T4 -p "$line" "$1" #-A
	done

	if [ $line=="80" ]
	then
		echo "Starting nikto scan at port 80..."
		nikto -h "$1"

	fi

	if [ $line=="139" ]
	then
		enum4linux "$1"

	fi

	if [ $line=="443" ]
	then
		echo "Starting nikto scan at port 443..."
		nikto -h "$1:443"
	fi

	if [ $line=="139" ]
	then
		enum4linux "$1"

	fi

fi
