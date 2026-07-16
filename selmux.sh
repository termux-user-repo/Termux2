#!/usr/bin/env bash

# ==========================================
# SELMUX.SH BETA
# Network & System Toolkit
# iSH + Termux Compatible
# ==========================================

VERSION="1.5 Beta"
AUTHOR="Termux User Repo"

RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"

clear


# ==========================================
# TERMINAL DETECTION
# ==========================================

if command -v termux-info >/dev/null 2>&1; then
    TERMINAL="Termux"

elif command -v apk >/dev/null 2>&1; then
    TERMINAL="iSH"

else
    echo -e "${RED}Unsupported terminal${RESET}"
    exit 1
fi


# ==========================================
# BASIC FUNCTIONS
# ==========================================

pause() {
    echo
    read -p "Press Enter to continue..."
}


banner() {

cat << "EOF"

███████╗███████╗██╗     ███╗   ███╗██╗   ██╗
██╔════╝██╔════╝██║     ████╗ ████║██║   ██║
███████╗█████╗  ██║     ██╔████╔██║██║   ██║
╚════██║██╔══╝  ██║     ██║╚██╔╝██║██║   ██║
███████║███████╗███████╗██║ ╚═╝ ██║╚██████╔╝
╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝ ╚═════╝

             SELMUX.SH BETA

EOF

}

# ==========================================
# NETWORK & SYSTEM TOOLS
# ==========================================

ip_locator() {

echo -e "${CYAN}Fetching Public IP...${RESET}"

if command -v curl >/dev/null 2>&1; then
    IP=$(curl -s https://api.ipify.org)
    echo -e "${GREEN}IP:${RESET} $IP"
else
    echo "curl missing"
fi

}


geo_location() {

echo -e "${CYAN}Getting Location...${RESET}"

if command -v curl >/dev/null 2>&1; then
    curl -s https://ipapi.co/json/
else
    echo "curl missing"
fi

}


dns_lookup() {

read -p "Domain: " domain

if command -v nslookup >/dev/null 2>&1; then
    nslookup "$domain"
else
    echo "nslookup missing"
fi

}


ping_test() {

read -p "Host: " host

ping -c 4 "$host"

}


system_info() {

echo "========= SYSTEM ========="

echo
echo "OS:"
uname -a

echo
echo "User:"
whoami

echo
echo "Shell:"
echo $SHELL

}


network_info() {

echo "========= NETWORK ========="

if command -v ip >/dev/null 2>&1; then
    ip addr
else
    ifconfig
fi

}


storage_info() {

echo "========= STORAGE ========="

df -h

}


battery_info() {

echo "========= BATTERY ========="

if command -v termux-battery-status >/dev/null 2>&1; then

    termux-battery-status

elif [ -f /sys/class/power_supply/battery/capacity ]; then

    cat /sys/class/power_supply/battery/capacity
    echo "%"

else

    echo "Battery unavailable"

fi

}


weather() {

read -p "City: " city

curl -s "https://wttr.in/$city?format=3"

}


speed_test() {

echo "Testing connection..."

curl -s https://speedtest.ftp.otenet.gr/files/test100k.db > /dev/null

echo "Finished"

}


generate_password() {

echo "Generated password:"

tr -dc 'A-Za-z0-9' </dev/urandom | head -c 16

echo

}


clock() {

while true
do
clear
date
sleep 1
done

}


dependencies() {

echo "Checking tools..."

for tool in curl wget ping nslookup
do

if command -v $tool >/dev/null 2>&1; then
    echo "[✓] $tool"
else
    echo "[X] $tool missing"
fi

done

}


about() {

echo
echo "SELMUX.SH BETA"
echo "Version: $VERSION"
echo "Author: $AUTHOR"
echo "Platform: $TERMINAL"

}

# ==========================================
# SETTINGS / UPDATE SYSTEM
# ==========================================

CONFIG_FILE="$HOME/.selmux_config"


save_theme() {
    echo "$1" > "$CONFIG_FILE"
}


load_theme() {

if [ -f "$CONFIG_FILE" ]; then
    THEME=$(cat "$CONFIG_FILE")
else
    THEME="GREEN"
fi


case $THEME in

GREEN)
GREEN="\033[1;32m"
;;

BLUE)
GREEN="\033[1;34m"
;;

RED)
GREEN="\033[1;31m"
;;

CYAN)
GREEN="\033[1;36m"
;;

esac

}


theme_menu() {

clear

echo "Select Theme"
echo
echo "[1] Green"
echo "[2] Blue"
echo "[3] Red"
echo "[4] Cyan"

read -p "Theme > " theme


case $theme in

1)
save_theme "GREEN"
;;

2)
save_theme "BLUE"
;;

3)
save_theme "RED"
;;

4)
save_theme "CYAN"
;;

*)
echo "Invalid theme"
;;

esac

load_theme

echo "Theme saved!"
}



update_selmux() {

echo "Checking updates..."

if command -v curl >/dev/null 2>&1; then

curl -s -o selmux_new.sh \
https://raw.githubusercontent.com/termux-user-repo/Termux2/refs/heads/main/selmux.sh


if [ -f selmux_new.sh ]; then

mv selmux_new.sh selmux.sh
chmod +x selmux.sh

echo "Update complete!"

else

echo "Update failed"

fi

else

echo "curl missing"

fi

}



credits() {

echo
echo "======================"
echo " SELMUX.SH BETA"
echo "======================"
echo
echo "Created by: $AUTHOR"
echo "Version: $VERSION"

}


# ==========================================
# LOG SYSTEM
# ==========================================

LOG_FILE="$HOME/selmux.log"
HISTORY_FILE="$HOME/selmux_history"


log_action() {

echo "$(date) - $1" >> "$LOG_FILE"

}


save_history() {

echo "$(date) : $1" >> "$HISTORY_FILE"

}


show_logs() {

clear

echo "========= LOGS ========="

if [ -f "$LOG_FILE" ]; then
    cat "$LOG_FILE"
else
    echo "No logs"
fi

pause

}


show_history() {

clear

echo "======= HISTORY ======="

if [ -f "$HISTORY_FILE" ]; then
    cat "$HISTORY_FILE"
else
    echo "No history"
fi

pause

}


dashboard() {

clear

echo "========= DASHBOARD ========="

echo
echo "Platform: $TERMINAL"
echo "Version : $VERSION"
echo "User    : $(whoami)"
echo "Date    : $(date)"

echo
uname -m

pause

}



# ==========================================
# PLUGIN SYSTEM
# ==========================================

PLUGIN_DIR="$HOME/selmux_plugins"


create_plugin_folder() {

mkdir -p "$PLUGIN_DIR"

}


load_plugins() {

create_plugin_folder

for plugin in "$PLUGIN_DIR"/*.sh
do

if [ -f "$plugin" ]; then
    source "$plugin"
fi

done

}


plugin_info() {

clear

echo "========= PLUGINS ========="

echo
echo "$PLUGIN_DIR"

ls "$PLUGIN_DIR"

pause

}



# ==========================================
# LANGUAGE SYSTEM
# ==========================================

LANG_FILE="$HOME/.selmux_lang"


set_language() {

echo "[1] English"
echo "[2] Türkçe"

read -p "Language > " lang


case $lang in

1)
echo "EN" > "$LANG_FILE"
;;

2)
echo "TR" > "$LANG_FILE"
;;

*)
echo "Invalid"
;;

esac

}


get_language() {

if [ -f "$LANG_FILE" ]; then

LANGUAGE=$(cat "$LANG_FILE")

else

LANGUAGE="EN"

fi

}

# ==========================================
# MAIN MENU
# ==========================================

menu() {

while true
do

clear
banner

echo -e "${GREEN}Platform:${RESET} $TERMINAL"
echo -e "${GREEN}Language:${RESET} $LANGUAGE"
echo

echo "[1]  🌐 IP Locator"
echo "[2]  📍 GeoLocation"
echo "[3]  🌍 DNS Lookup"
echo "[4]  📡 Ping Test"
echo "[5]  🖥 System Info"
echo "[6]  📶 Network Info"
echo "[7]  ⚙ Dependencies"
echo "[8]  ℹ About"
echo "[9]  💾 Storage Info"
echo "[10] 🔋 Battery Info"
echo "[11] 🌦 Weather"
echo "[12] ⚡ Speed Test"
echo "[13] 🔐 Password Generator"
echo "[14] ⏰ Clock"
echo "[15] 🔄 Update SELMUX"
echo "[16] 🎨 Theme Settings"
echo "[17] 👥 Credits"
echo "[18] 📜 Logs"
echo "[19] 🕘 History"
echo "[20] 📊 Dashboard"
echo "[21] 🧩 Plugins"
echo "[22] 🌍 Language"
echo "[0]  🚪 Exit"

echo

read -p "SELMUX > " choice


save_history "$choice"
log_action "Selected $choice"


case $choice in

1)
ip_locator
pause
;;

2)
geo_location
pause
;;

3)
dns_lookup
pause
;;

4)
ping_test
pause
;;

5)
system_info
pause
;;

6)
network_info
pause
;;

7)
dependencies
pause
;;

8)
about
pause
;;

9)
storage_info
pause
;;

10)
battery_info
pause
;;

11)
weather
pause
;;

12)
speed_test
pause
;;

13)
generate_password
pause
;;

14)
clock
;;

15)
update_selmux
pause
;;

16)
theme_menu
pause
;;

17)
credits
pause
;;

18)
show_logs
;;

19)
show_history
;;

20)
dashboard
;;

21)
plugin_info
;;

22)
set_language
get_language
pause
;;

0)
echo "Closing SELMUX.SH..."
exit 0
;;

*)
echo "Invalid option"
sleep 1
;;

esac

done

}



# ==========================================
# START SELMUX
# ==========================================

load_theme
load_plugins
get_language

clear
banner

echo "Starting SELMUX.SH..."
sleep 1

menu
