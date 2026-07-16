#!/bin/bash

# Clear screen and display start
clear
echo "##################"
echo "< combat v1 Activated >"
echo -n "System 32 Loading "

# Spin animation
spinner="\\|/-"
for i in {1..20}; do
    printf "\b${spinner:i%${#spinner}:1}"
    sleep 0.1
done
printf "\bDone!\n"

# Initial Choice
read -p "Continue? (y/n): " choice
if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
    echo "Exiting..."
    exit 0
fi

# Downloading simulation
echo "Downloading main b geolocation"
bar="          "
for i in {1..10}; do
    bar="#"${bar%?}
    printf "\r[${bar// /—}]"
    sleep 0.3
done
echo -e "\nDownload Complete."

# Sniffer animation
echo -n "İp sniffer activation "
for i in {1..4}; do
    printf "\b\\"
    sleep 0.2
    printf "\b|"
    sleep 0.2
done
printf "\bDone!\n\n"

# Final Menu
echo "1 : Get my IP address"
echo "2 : Get my geolocation"
read -p "Select an option (1/2): " opt

case $opt in
    1)
        echo "Your Public IP is: $(curl -s https://ifconfig.me)"
        ;;
    2)
        echo "Fetching location data..."
        curl -s https://ipapi.co/json/ | grep -E "city|region|country_name"
        ;;
    *)
        echo "Invalid option."
        ;;
esac
