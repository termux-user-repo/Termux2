#!/bin/bash

# --- ASCII Art ---
clear
echo "  ____  _____ _     __  __ _   _ __  __ "
echo " / ___|| ____| |   |  \/  | | | |  \/  |"
echo " \___ \|  _| | |   | |\/| | | | | |\/| |"
echo "  ___) | |___| |___| |  | | |_| | |  | |"
echo " |____/|_____|_____|_|  |_|\___/|_|  |_|"
echo "          SH .beta.                        "
echo ""

# --- Loading Animation ---
echo -n "Loading: "
spinner="\|/-"
for i in {1..8}; do
    echo -ne "\rLoading: ${spinner:i%4:1}"
    sleep 0.2
done
echo -e "\rLoading Complete!    \n"

# --- Main Menu ---
echo "1 — IP Giver"
echo "2 — GeoLocation"
echo "3 — System Uptime"
echo "4 — Check Disk Space"
echo "5 — Exit"

# Force input from keyboard
read -p "Select [1-5]: " choice </dev/tty

case $choice in
    1)
        echo -n "Your Public IP: "
        curl -s https://ifconfig.me
        echo "" ;;
    2)
        echo "Fetching Location..."
        curl -s https://ipapi.co/json | grep -E 'city|region|country_name' ;;
    3)
        echo -n "System Uptime: "
        uptime ;;
    4)
        echo "Disk Usage:"
        df -h | grep '^/dev/' ;;
    5)
        echo "Exiting..."
        exit ;;
    *)
        echo "Invalid Selection." ;;
esac
