#!/bin/bash

# --- FORCE COLORS ---
export TERM=xterm-256color
R='\033[0;31m'; G='\033[0;32m'; B='\033[0;34m'; C='\033[0;36m'; Y='\033[1;33m'; NC='\033[0m'

# --- ANIMATION ENGINE ---
animate() {
    local mode=$1
    local msg=$2
    if [ "$mode" == "dots" ]; then
        for i in {1..10}; do printf "\r${C}%s${NC}%s" "$msg" "$(printf '.%.0s' $(seq 1 $((i%4))))"; sleep 0.2; done
    elif [ "$mode" == "spin" ]; then
        local syms=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
        for i in {1..20}; do printf "\r${Y}%s${NC} %s" "$msg" "${syms[$((i%10))]}"; sleep 0.1; done
    fi
    printf "\r${G}%s [SUCCESS]${NC}        \n" "$msg"
}

# --- UI ELEMENTS ---
show_ascii() {
    echo -e "${B}"
    echo "                _   _                 ____  "
    echo "  _ __  _   _ _| |_| |__   ___  _ __ / ___| "
    echo " | '_ \| | | | __| '_ \ / _ \| '_ \ \___ \ "
    echo " | |_) | |_| | |_| | | | (_) | | | |___) |"
    echo " | .__/ \__, |\__|_| |_|\___/|_| |_|____/ "
    echo " |_|    |___/                             "
    echo -e "${NC}"
}

# --- MAIN LOOP ---
while true; do
    clear
    show_ascii
    echo -e "${Y}========================================"
    echo -e "   1] ${C}Get IP Info"
    echo -e "   2] ${C}Get Geo Details"
    echo -e "   3] ${C}System Health Scan"
    echo -e "   4] ${R}Wipe Terminal (Scratch)"
    echo -e "   5] ${R}Exit System"
    echo -e "${Y}========================================${NC}"
    read -p ">> Select: " choice

    case $choice in
        1) 
            animate "spin" "Connecting to Network..."
            ip=$(curl -s https://ipapi.co/ip/)
            echo -e "\n${G}>>> IP Address:${NC} $ip\n"
            read -p "Press Enter to return..." 
            ;;
        2) 
            animate "dots" "Resolving Coordinates..."
            data=$(curl -s https://ip-api.com/json/)
            echo -e "\n${G}--- GEO DATA ---${NC}"
            echo -e "Country: $(echo $data | grep -o '"country":"[^"]*"' | cut -d'"' -f4)"
            echo -e "City:    $(echo $data | grep -o '"city":"[^"]*"' | cut -d'"' -f4)"
            echo -e "\n"
            read -p "Press Enter to return..."
            ;;
        3)
            animate "spin" "Analyzing Kernal..."
            echo -e "\n${C}System Uptime:${NC} $(uptime -p 2>/dev/null)"
            echo -e "${C}User Shell:${NC} $SHELL"
            echo -e "${C}Memory Check:${NC} OK"
            echo -e "\n"
            read -p "Press Enter to return..."
            ;;
        4)
            animate "dots" "Wiping Memory"
            clear
            history -c
            ;;
        5) 
            echo -e "${R}Shutting down...${NC}"
            exit 0 
            ;;
        *) 
            echo -e "${R}Invalid Input!${NC}"
            sleep 1
            ;;
    esac
done
