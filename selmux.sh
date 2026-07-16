#!/usr/bin/env bash

#=========================================
# SELMUX.SH BETA
# Works on Termux & iSH
#=========================================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

clear

spinner() {
    spin='|/-\'
    for i in $(seq 1 40); do
        printf "\r${CYAN}Loading files... %c${RESET}" "${spin:i%4:1}"
        sleep 0.08
    done
    echo
}

banner() {
cat << "EOF"

   _____ ______ _      __  __ _    _ __   __
  / ____|  ____| |    |  \/  | |  | |\ \ / /
 | (___ | |__  | |    | \  / | |  | | \ V /
  \___ \|  __| | |    | |\/| | |  | |  > <
  ____) | |____| |____| |  | | |__| | / . \
 |_____/|______|______|_|  |_|\____/ /_/ \_\

              SELMUX.SH BETA

EOF
}

choose_terminal() {
echo
echo -e "${YELLOW}Select your terminal:${RESET}"
echo
echo -e "${GREEN}[1]${RESET} iSH Terminal"
echo -e "${GREEN}[2]${RESET} Termux"
echo

read -p "Choice: " choice

case "$choice" in
1) TERMINAL="iSH";;
2) TERMINAL="Termux";;
*)
echo -e "${RED}Invalid option!${RESET}"
exit 1
;;
esac

spinner
}

ip_locator() {

echo
echo -e "${CYAN}Fetching public IP...${RESET}"

if command -v curl >/dev/null 2>&1; then
    curl -s https://api.ipify.org
elif command -v wget >/dev/null 2>&1; then
    wget -qO- https://api.ipify.org
else
    echo "curl or wget required."
fi

echo
echo
read -p "Press Enter..."
}

geo_location() {

echo
echo -e "${CYAN}Fetching location...${RESET}"

if command -v curl >/dev/null 2>&1; then
    curl -s https://ipapi.co/json/
elif command -v wget >/dev/null 2>&1; then
    wget -qO- https://ipapi.co/json/
else
    echo "curl or wget required."
fi

echo
echo
read -p "Press Enter..."
}

menu() {

while true
do
clear
banner

echo -e "${GREEN}Running on:${RESET} $TERMINAL"
echo

echo -e "${BLUE}[1]${RESET} 🌐 IP Locator"
echo -e "${BLUE}[2]${RESET} 📍 GeoLocation"
echo -e "${BLUE}[3]${RESET} ℹ About"
echo -e "${BLUE}[0]${RESET} 🚪 Exit"

echo
read -p "Select: " option

case "$option" in

1)
ip_locator
;;

2)
geo_location
;;

3)
clear
banner
echo
echo "Version : Beta"
echo "Author  : Termux User Repo"
echo
echo "Compatible with:"
echo "✔ Termux"
echo "✔ iSH"
echo
echo "Thanks for using SELMUX.SH!"
echo
read -p "Press Enter..."
;;

0)
echo
echo -e "${GREEN}Goodbye!${RESET}"
exit 0
;;

*)
echo
echo -e "${RED}Invalid option.${RESET}"
sleep 1
;;

esac

done

}

choose_terminal
menu
