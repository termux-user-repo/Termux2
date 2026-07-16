#!/bin/bash

# ASCII Art
clear
echo "  ____  _____ _     __  __ _   _ __  __ "
echo " / ___|| ____| |   |  \/  | | | |  \/  |"
echo " \___ \|  _| | |   | |\/| | | | | |\/| |"
echo "  ___) | |___| |___| |  | | |_| | |  | |"
echo " |____/|_____|_____|_|  |_|\___/|_|  |_|"
echo "          SH .beta.                        "
echo ""

# Rotating Loading Animation
echo -n "Loading: "
spinner="\|/-"
for i in {1..12}; do
    echo -ne "\rLoading: ${spinner:i%4:1}"
    sleep 0.2
done
echo -e "\rLoading Complete!    "
echo ""

# Menu
echo "1 — IP GIVER"
echo "2 — GeoLocation"
read -p "Select [1/2]: " choice

if [ "$choice" == "1" ]; then
    echo -n "Your Public IP: "
    curl -s https://ifconfig.me
    echo ""
elif [ "$choice" == "2" ]; then
    echo "Fetching Location..."
    curl -s https://ipapi.co/json | grep -E 'city|region|country_name'
else
    echo "Invalid Selection."
fi
