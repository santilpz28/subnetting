#!/bin/bash

#Colours
eC="\033[0m\e[0m" # end colour
bC="\e[0;34m\033[1m" # blue colour
yC="\e[0;33m\033[1m" # yellow colour
pC="\e[0;35m\033[1m" # purple colour
tC="\e[0;36m\033[1m" # turquoise colour


ip=$1
mask=$2

url="https://blog.jodies.de/ipcalc?host=${ip}&mask1=${mask}&mask2="

# Download information and save in a document
curl -s "$url" > subnetting_temporal_file.txt

# Obtain all the information required:
# Network Mask
network_mask=$(cat subnetting_temporal_file.txt | grep "Netmask" | awk -F 'ff">' '{print $3}' | awk '{print $1}')

# Network ID
network_id=$(cat subnetting_temporal_file.txt | grep "Network"  | awk -F 'ff">' '{print $2}' | awk '{print $1}' | awk -F '/' '{print $1}')

# Broadcast Address
broadcast_address=$(cat subnetting_temporal_file.txt | grep "Broadcast" | awk -F 'ff">' '{print $3}' | awk '{print $1}')

# Print the result
echo -e "\n${yC}[+]${eC} Address: ${bC}$ip${eC} | Mask: ${pC}$mask${eC}"
echo -e "\n\t[+] Network Mask:"${bC}$network_mask${eC}""
echo -e "\t[+] Network ID:"${pC}$network_id${eC}""
echo -e "\t[+] Broadcast Address: "${tC}$broadcast_address${eC}"\n"

# Delete Temporal files
rm subnetting_temporal_file.txt