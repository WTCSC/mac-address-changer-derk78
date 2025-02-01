import subprocess
import re 
import os
import sys

def validate_mac(mac_address):
    
    #Use this regular expression to check if the input is in the correct MAC address format.
    mac_pattern = r"^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$"

    #If it matches then return that the MAC address was valid otherwise ask for a valid MAC address.
    #Also need to return "False" or "True" based on whether the pattern was valid so that we can evaluate the output later in the main function.
    if re.match(mac_pattern, mac_address):
        print("Entered valid MAC address.") 
        return True
    else:
        print("Please enter a valid MAC address.")
        return False
    
def check_root():
    
    #Use subproccess.run to run a shell command that checks if the user has root privileges if not prompt the user to run the script at the root level otherwise they're good to go.
    result = subprocess.run(["id", "-u"], capture_output=True, text=True)

    if result.stdout.strip() != "0": 
        print("Please run the script at the root level.")
        sys.exit(1)
    else:
        None
        
def check_interface(interface):
    
    #checks the file system that is on all Linux systems to see if the network interface exists.
    #Again we need it to return "True" or "False" based on the output so that the `main` function can later evaluate it.
    result = subprocess.run(['test', '-d', f'/sys/class/net/{interface}'], capture_output=True, text=True)
    if result.returncode == 0:
        print(f"The network interface {interface} exists.")
        return True
    else:
        print(f"The network interface {interface} doesn't exist. Please enter a valid interface.")
        return False
        
def change_mac(interface, new_mac):
    
    #Use subprocess.run again to run the shell commands to bring the network interface down then set the new adress and finally bring the network interface back up.
    try:
        subprocess.run(["ip", "link", "set", interface, "down"], check=True, capture_output=True, text=True)
        subprocess.run(["ip", "link", "set", interface, "address", new_mac], check=True, capture_output=True, text=True)
        subprocess.run(["ip", "link", "set", interface, "up"], check=True, capture_output=True, text=True)
        print(f"Changing the MAC address for {interface} to {new_mac}.")

    except subprocess.CalledProcessError as e:
        print(f"An error occured: {e}")

#Actually run the script.
def main():

    check_root()

    interface = input(f"Please enter the network interface: ")

    new_mac = input(f"Please enter the new MAC address: ")

    #check if they input a valid interface, if not exit.
    if not check_interface(interface):
        sys.exit(1)


    #Check if they input a valid MAC address, if not exit.
    if not validate_mac(new_mac):
        sys.exit(1)

    change_mac(interface, new_mac)
    
    print(f"The MAC address was succesfully changed to: {new_mac}")

if __name__ == "__main__": 
    main()
