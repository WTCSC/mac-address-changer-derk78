import sys
import subprocess
import re 
import os

def validate_mac(mac_address):
    
    mac_pattern = r"^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$"
    if re.match(mac_pattern, mac_address):
        print("\nEntered valid MAC address.") 
    else:
        print("\nPlease enter a valid MAC address.")
    
def check_root():
    
    if sys.platform == "win32":
        print("Cannot run root check.")
    
    result = subprocess.run(["-id", "-u"], capture_output=True, text=True)

    if result.returncode != 0: 
        print("Please run the script at the root level.")
        sys.exit(1)
    else:
        print("The Script is running at the root level.")
        
def check_interface(interface):
    
    result = subprocess.run(['test', '-d', f'/sys/class/net/{interface}'], capture_output=True, text=True)
    if result.returncode == 0:
        print(f"The network interface {interface} exists.")
    else:
        print(f"The network interface {interface} doesn't exist.")
        sys.exit(1)
        
def change_mac():
    
    