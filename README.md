[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/tp86o73G)
[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=17781057)

# Shell MAC Address Changer

**This script can only be run on linux.**

### How to use it
- To run the script you have to use the `chmod +x` command on the file to give yourself execution privileges.
- Once you give yourself execution privileges to actually run the script you have to enter the path to the file in this case it would be `./mac_changer.sh`, the period at the beginning representing the current directory 
- You also need to run the script at the root level using the `sudo` command before the path to the file.

### Dependencies
This script has no dependencies other then having bash installed and being on a Linux system.
### Error handling
*This script has three functions to handle errors, `check_root`, `check_mac`, and `check_interface`.*
- The `check_mac` function makes sure that the input is in the right format, if not it will return an error.
- The `check_root` function ensures that you run the script at the root level with the sudo command and will prompt you to if you haven't.
- Finally `check_interface` will check if the interface the MAC address will be assigned to actually exists on the system.

### Example usage
**Errors:**

  ![alt text](image.png)

Example of something other than a MAC address being input into the script.

  ![alt text](image-1.png)

Example of a network interface the MAC address doesn't belong to being input.

**Changing the actual MAC address:**

![alt text](image-2.png)

Process of changing the MAC address on its actual network interface.