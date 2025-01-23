#!/bin/bash
new_address=$1
interface=$2

#set -e 

check_mac() {
    if [[ $new_address =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$ ]]; then 
        echo -e "\nEntered valid MAC address"
    else 
        echo "Please enter a valid MAC address"
        exit 1
    fi
}

check_root() {
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run the script at the root level"
        exit 1 
    fi
}

check_interface() {
    if [ -d "/sys/class/net/$interface" ]; then
        echo "The network interface exists"
    else 
        echo "The network interface does not exist. Please enter a valid interface."
        exit 1 
    fi
}

check_root

read -p "Please enter the MAC address: " new_address
read -p "Please enter the network interface: " interface

check_mac

check_interface

echo -e "\nChanging the MAC address for the $interface interface to $new_address"
ip link set "$interface" down 
ip link set dev "$interface" address "$new_address"
ip link set "$interface" up

echo "MAC address was succesfully changed to: $new_address"
exit 0
