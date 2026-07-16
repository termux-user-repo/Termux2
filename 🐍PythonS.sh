#!/bin/bash

# --- COLORS ---
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Ensure required tools
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
            printf "\r${CYAN}%s [%s]${NC}" "$message" "$s"
            sleep 0.1
        done
    done
    printf "\r${GREEN}%s [Done]${NC}    \n" "$message"
}

show_ascii() {
    echo -e "${BLUE}"
    cat << "EOF"
                _   _                 ____  
  _ __  _   _ _| |_| |__   ___  _ __ / ___| 
 | '_ \| | | | __| '_ \ / _ \| '_ \ \___ \ 
 | |_) | |_| | |_| | | | (_) | | | |___) |
 | .__/ \__, |\__|_| |_|\___/|_| |_|____/ 
 |_|    |___/                             
EOF
    echo -e "${NC}"
}

# --- MAIN MENU LOOP ---
while true; do
    clear
    show_ascii
    echo -e "${YELLOW}--- SYSTEM CONTROL PANEL ---${NC}"
    echo -e "1) ${GREEN}View Public IP${NC}"
    echo -e "2) ${GREEN}View Geolocation${NC}"
    echo -e "3) ${GREEN}System Info${NC}"
    echo -e "4) ${RED}Scratch/Clear Logs${NC}"
    echo -e "5) ${RED}Exit${NC}"
    echo -e "----------------------------"
    read -p "Select Option: " choice
    
    case $choice in
        1)
            loading 1.5 "Fetching IP..."
            ip=$(curl -s https://ipapi.co/ip/)
            echo -e "\n>>> Your IP: ${CYAN}$ip${NC}\n"
            read -p "Press Enter..."
            ;;
        2)
            loading 2 "Scanning Geo Data..."
            data=$(curl -s https://ip-api.com/json/)
            echo -e "\n>>> Geo Details:"
            echo -e "Country: $(echo $data | grep -o '"country":"[^"]*"' | cut -d'"' -f4)"
            echo -e "City:    $(echo $data | grep -o '"city":"[^"]*"' | cut -d'"' -f4)"
            echo -e "ISP:     $(echo $data | grep -o '"isp":"[^"]*"' | cut -d'"' -f4)\n"
            read -p "Press Enter..."
            ;;
        3)
            echo -e "\n${CYAN}--- SYSTEM SPECS ---${NC}"
            echo -e "User: $(whoami)"
            echo -e "Uptime: $(uptime -p 2>/dev/null || echo 'N/A')"
            echo -e "Shell: $SHELL\n"
            read -p "Press Enter..."
            ;;
        4)
            echo -e "\n${RED}Cleaning session logs...${NC}"
            history -c 2>/dev/null
            clear
            echo "Logs scrubbed."
            sleep 1
            ;;
        5)
            echo -e "${RED}Shutting down...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid Selection!${NC}"
            sleep 1
            ;;
    esac
done
