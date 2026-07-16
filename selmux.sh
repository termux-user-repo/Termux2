#!/bin/bash

clear

echo "===================================="
echo "         SELMUX.SH BETA"
echo "===================================="
echo
echo "Are you using?"
echo "1) iSH Terminal"
echo "2) Termux"
echo
read -p "Select (1-2): " choice

case $choice in
    1)
        PLATFORM="iSH Terminal"
        ;;
    2)
        PLATFORM="Termux"
        ;;
    *)
        echo "Invalid selection."
        exit 1
        ;;
esac

clear
echo "Loading required files for $PLATFORM..."

spinner='|/-\'
for i in {1..40}; do
    printf "\r%c" "${spinner:i%4:1}"
    sleep 0.08
done

clear

cat << "EOF"

   _____      _                     
  / ____|    | |                    
 | (___   ___| |_ __ ___  _   ___  __
  \___ \ / _ \ | '_ ` _ \| | | \ \/ /
  ____) |  __/ | | | | | | |_| |>  <
 |_____/ \___|_|_| |_| |_|\__,_/_/\_\

           SELMUX.SH BETA

==========================================
 Features
==========================================
|------ 1. IP Locator
|          Locates user's public IP
|
|------ 2. GeoLocation
|          Shows approximate location
|
|------ selmux.SH beta file thanks ------|
==========================================

EOF

echo
read -p "Choose a feature (1-2): " feature

case $feature in
    1)
        echo
        echo "Public IP:"
        curl -s https://api.ipify.org
        echo
        ;;
    2)
        echo
        echo "Geolocation:"
        curl -s https://ipapi.co/json/
        echo
        ;;
    *)
        echo "Invalid option."
        ;;
esac
