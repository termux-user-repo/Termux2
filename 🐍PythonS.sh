#!/bin/bash

# Ensure required tools are present
if ! command -v curl &> /dev/null; then
    command -v pkg &> /dev/null && pkg install curl -y
    command -v apk &> /dev/null && apk add curl
fi

# Animation function
loading() {
    local duration=$1
    local message=$2
    local end_time=$((SECONDS + duration))
    local syms=("\\" "|" "/" "-")
    while [ $SECONDS -lt $end_time ]; do
        for s in "${syms[@]}"; do
            printf "\r%s [%s]" "$message" "$s"
            sleep 0.1
        done
    done
    printf "\r%s [Done]    \n" "$message"
}

# --- UI ELEMENTS ---
show_ascii() {
    cat << "EOF"
                _   _                 ____  
  _ __  _   _ _| |_| |__   ___  _ __ / ___| 
 | '_ \| | | | __| '_ \ / _ \| '_ \ \___ \ 
 | |_) | |_| | |_| | | | (_) | | | |___) |
 | .__/ \__, |\__|_| |_|\___/|_| |_|____/ 
 |_|    |___/                             
EOF
}

# --- INITIAL LAUNCH ---
clear
echo "————————————————————————————————————————"
echo "      W E L C O M E   T O   🐍   p y t h o n S"
echo "————————————————————————————————————————"
loading 3 "🐍 PythonS System Launching"
echo "System Initialized."

# --- MAIN MENU LOOP ---
while true; do
    # Clear screen and show header every time the menu loops
    clear
    show_ascii
    echo -e "\n|—— 1: IP | 2: Geo | 3: Exit ——|"
    read -p "|_ Choice: " choice
    
    case $choice in
        1)
            loading 1.5 "Requesting Public IP..."
            ip=$(curl -s https://ipapi.co/ip/)
            echo -e "\n>>> Your Public IP: $ip"
            read -p "Press Enter to return to menu..."
            ;;
        2)
            loading 1.5 "Locating Server Coordinates..."
            data=$(curl -s https://ip-api.com/json/)
            echo -e "\n>>> Current Geolocation Info:"
            echo "    Country:   $(echo $data | grep -o '"country":"[^"]*"' | cut -d'"' -f4)"
            echo "    City:      $(echo $data | grep -o '"city":"[^"]*"' | cut -d'"' -f4)"
            echo "    ISP:       $(echo $data | grep -o '"isp":"[^"]*"' | cut -d'"' -f4)"
            echo ""
            read -p "Press Enter to return to menu..."
            ;;
        3)
            echo "Shutting down..."
            exit 0
            ;;
        *)
            echo "[!] Invalid input."
            sleep 1
            ;;
    esac
done
