#!/bin/bash

# Define Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

clear
echo -e "${GREEN}##################"
echo -e "< ${CYAN}combat v1 Activated${GREEN} >${NC}"

# Spinner for 2 seconds
echo -n "System 32 Loading "
spinner=("\\" "|" "/" "-")
start_time=$SECONDS
while (( SECONDS - start_time < 2 )); do
    for i in "${spinner[@]}"; do
        printf "\b${CYAN}$i${NC}"
        sleep 0.1
    done
done
printf "\b \n"

# Continue Prompt
read -p "Continue? (y/n): " choice
if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
    echo -e "${RED}Exiting system...${NC}"
    exit 0
fi

# Downloading simulation
echo -e "${CYAN}Downloading main b geolocation${NC}"
bar="####################"
for ((i=1; i<=20; i++)); do
    printf "\r[${GREEN}${bar:0:i}${NC}——]"
    sleep 0.15
done
echo -e "\n${GREEN}Download Complete.${NC}"

# Sniffer Animation
echo -n "İp sniffer activation "
for i in {1..2}; do
    printf "${RED}\\${NC}"
    sleep 0.3
    printf "\b"
done
echo -e "${GREEN}Done!${NC}\n"

# Extra Feature: System Integrity Check
echo -e "${CYAN}[!] Running system integrity check...${NC}"
sleep 1
echo -e "${GREEN}[+] Status: Stable${NC}"
sleep 0.5

# Final Options
echo -e "\n${CYAN}--- SELECT MODULE ---${NC}"
echo -e "1) ${GREEN}Retrieve IP Address${NC}"
echo -e "2) ${GREEN}Extract Geolocation Data${NC}"
read -p "Select [1/2]: " opt

case $opt in
    1)
        echo -e "\n${CYAN}Targeting IP...${NC}"
        curl -s https://ifconfig.me
        echo -e "\n"
        ;;
    2)
        echo -e "\n${CYAN}Fetching Geo-Data...${NC}"
        # Adding a fake delay to make it feel more "advanced"
        sleep 1
        curl -s https://ipapi.co/json/ | grep -E "city|region|country_name"
        ;;
    *)
        echo -e "${RED}Invalid module selection. Aborting.${NC}"
        ;;
esac
