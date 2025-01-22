#!/bin/bash
new_address=$1
interface=$2

check_mac() {
    if [[ $new_address =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$ ]]; then 
        echo "Entered valid MAC address"
        exit 0
    else 
        echo "Please enter valid MAC address"
        exit 1
    fi
}

check_root() {
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run at root"
        exit 1
    else 
        exit 0
    fi
}

check_interface() {
    if [ -d "/sys/class/net/$interface" ]; then
        echo "The network interface exists"
        exit 0 
    else 
        exit 1
    fi
}

ip link set $interface down 

ip link set "$new_address" hw ether "$interface"

ip link set dev "$interface" address "$mac_address"

ip link set dev "$interface" up