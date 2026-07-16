#!/bin/bash

# --- Loading Animation ---
clear
echo -ne "selmux v1 launching…. ("
for i in {1..7}; do
    echo -ne "#"
    sleep 0.2
done
echo ")"

echo -e "\nselmux v1 launched beta"
read -p "say or print “1” to launch 🚀: " choice

if [ "$choice" == "1" ]; then
    # --- Confirmation ---
    read -p "Confirm action (y/n)? " confirm
    if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ]; then
        
        # --- The Menu ---
        echo -e "\n      Selmux SH Beta"
        echo -e "1—İP GIVER"
        echo -e "|"
        echo -e "2—GeoLocation"
        echo ""
        
        read -p "Select an option: " menu_choice
        
        case $menu_choice in
            1)
                echo "Fetching your IP..."
                curl -s https://ifconfig.me
                echo ""
                ;;
            2)
                echo "Fetching GeoLocation..."
                # Using ip-api.com for a free, simple lookup
                curl -s https://ip-api.com/line
                echo ""
                ;;
            *)
                echo "Invalid option."
                ;;
        esac
    else
        echo "Action cancelled."
    fi
else
    echo "Launch aborted."
fi
