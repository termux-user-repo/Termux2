#!/bin/bash

# --- ASCII Art ---
clear
echo -e "\033[1;36m"
echo "  ____  _____ _     __  __ _   _ __  __ "
echo " / ___|| ____| |   |  \/  | | | |  \/  |"
echo " \___ \|  _| | |   | |\/| | | | | |\/| |"
echo "  ___) | |___| |___| |  | | |_| | |  | |"
echo " |____/|_____|_____|_|  |_|\___/|_|  |_|"
echo "          SH .beta.                        "
echo -e "\033[0m"

# --- Rotating Loading ---
echo -n "Loading: "
spinner="/-\|"
for i in {1..8}; do
    echo -ne "\rLoading: ${spinner:i%${#spinner}:1}"
    sleep 0.2
done
echo -e "\rLoading Complete!    \n"

# --- Main Script ---
read -p "say or print “1” to launch 🚀: " choice
if [ "$choice" == "1" ]; then
    read -p "Confirm action (y/n)? " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        
        echo -e "\n--- Selmux SH Beta ---"
        echo "1—İP GIVER"
        echo "|"
        echo "2—GeoLocation"
        echo "3—System Info"
        echo "4—Exit"
        echo ""
        
        read -p "Select option: " menu_choice
        
        case $menu_choice in
            1) 
                echo -e "\nYour IP: $(curl -s https://ifconfig.me)" ;;
            2) 
                echo -e "\nFetching Location..."
                # Using a different API structure that is more reliable
                curl -s https://ipapi.co/json/ | grep -E 'city|region|country_name|ip' ;;
            3)
                echo -e "\nDevice: $(uname -a)" ;;
            4)
                exit ;;
            *)
                echo "Invalid selection." ;;
        esac
    else
        echo "Cancelled."
    fi
else
    echo "Launch aborted."
fi
