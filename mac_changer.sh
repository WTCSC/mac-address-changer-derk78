#!/bin/bash
new_address=$1
interface=$2

check_mac() {
    #This if statement checks user input for the new address to make sure it's in the right format for a MAC address.
    #It does this by checking characters 0 through 9  and a through f including capitales.
    #This regular expression works by matching two characters hexdecimal divided by colons repeated five times because each MAC address have 6 octets, 6 pairs of dexadecimal numbers.
    #`^` marks the beginning of the string and the `$` marks the end of the string 
    if [[ $new_address =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$ ]]; then 
        echo -e "\nEntered valid MAC address."
    else 
        echo -e "\nPlease enter a valid MAC address."
        exit 1
    fi
}

check_root() {
    #This if statement checks if the user isn't running the script at the root, Effective User ID (EUID) checks if the user is running the script as the root user 
    #If the person running it is the root user it will return a 0 and if it isn't equal to 0 represented by the `-ne` then it will prompt the error message and tell the user to run it at root.
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run the script at the root level."
        exit 1 
    fi
}

check_interface() {
    #This if statement checks the filesystem that is on all Linux systems which contains all the network interfaces on the system
    #to see if the specific requested interface exists.
    if [ -d "/sys/class/net/$interface" ]; then
        echo "The network interface exists."
    else 
        echo "The network interface does not exist. Please enter a valid interface."
        exit 1 
    fi
}

#Here I call the functions for the checks that I want to run for the actual script 
#I first run the `check_root` function since I want it to run first to make sure the user is running it at the root level.
#Then I prompt the user to enter in the new MAC address they want to change their current one to, and run the rest of the checks.

check_root

read -p "Please enter the new MAC address: " new_address
read -p "Please enter the network interface: " interface

check_mac

check_interface


#Inform the user that the MAC address is being changed.
echo -e "\nChanging the MAC address for the $interface interface to $new_address."

#In order to change the MAC address we must bring the network interface down first.
ip link set "$interface" down 

#Change the MAC address on the specific interface.
ip link set dev "$interface" address "$new_address"

#Bring the network interface back up.
ip link set "$interface" up

#Let the user know the MAC address was succesfully changed.
echo "The MAC address was succesfully changed to: $new_address"
exit 0
