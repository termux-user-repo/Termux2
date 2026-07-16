#!/bin/bash

# --- FORCE BASH ---
# This ensures even if you run it in iSH, it uses the actual bash interpreter.

# --- INSTALLER ---
if ! command -v curl &> /dev/null; then
    echo "Installing missing requirements..."
    command -v pkg &> /dev/null && pkg install curl -y
    command -v apk &> /dev/null && apk add curl
fi

# --- LOADING FUNCTIONS ---
# Function 1: Rotating cursor
rotate_loader() {
    local msg=$1
    local delay=0.1
    for i in {1..20}; do
        printf "\r%s %s" "$msg" "$(echo '\|/-' | cut -c $((i%4+1)))"
        sleep $delay
    done
    printf "\r%s [Done]    \n" "$msg"
}

# Function 2: Progress bar
progress_bar() {
    local msg=$1
    printf "%s " "$msg"
    for i in {1..20}; do
        printf "%%"
        sleep 0.1
    done
    printf " [Successfully Loaded]\n"
}

# --- INITIALIZATION ---
clear
rotate_loader "Installing git"
rotate_loader "🐍 pythonS loading..."
progress_bar "System"
sleep 3

# --- MAIN MENU ---
while true; do
    clear
    echo "========================================"
    echo "      W E L C O M E   T O   pythonS     "
    echo "========================================"
    echo " 1) Get IP"
    echo " 2) Get Geo"
    echo " 3) Exit"
    echo "========================================"
    
    # Using read without -p for maximum compatibility
    printf "Select Option: "
    read choice

    case "$choice" in
        1)
            echo "Fetching IP..."
            curl -s https://ipapi.co/ip/
            echo -e "\nPress Enter..."
            read
            ;;
        2)
            echo "Fetching Geo..."
            curl -s https://ip-api.com/json/
            echo -e "\nPress Enter..."
            read
            ;;
        3)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid selection."
            sleep 1
            ;;
    esac
done
