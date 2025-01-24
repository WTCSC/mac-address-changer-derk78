#!/bin/bash
new_address=$1
interface=$2

check_mac() {
    #This if statement checks user input for the new address to make sure it's in the right format for a MAC address.
    #It does this by checking characters 0 through 9 a through f including capitales =----
    if [[ $new_address =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$ ]]; then 
        echo -e "\nEntered valid MAC address."
    else 
        echo -e "\nPlease enter a valid MAC address."
        exit 1
    fi
}

check_root() {
    #This if statement checks if the user isn't running the script at the root Effective User ID (EUID) checks if the user running the script is the root user 
    #If the person running it is the root user it will return a 0 and if it isn't equal to 0 then they need to gain root privileges.
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run the script at the root level."
        exit 1 
    fi
}

check_interface() {
    if [ -d "/sys/class/net/$interface" ]; then
        echo "The network interface exists."
    else 
        echo "The network interface does not exist. Please enter a valid interface."
        exit 1 
    fi
}

check_root

read -p "Please enter the new MAC address: " new_address
read -p "Please enter the network interface: " interface

check_mac

check_interface

echo -e "\nChanging the MAC address for the $interface interface to $new_address."
ip link set "$interface" down 
ip link set dev "$interface" address "$new_address"
ip link set "$interface" up

echo "The MAC address was succesfully changed to: $new_address"
exit 0
