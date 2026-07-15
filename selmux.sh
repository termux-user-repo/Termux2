#!/bin/bash

# --- Loading Animation ---
echo -n "selmux v1 launching…. ("
for i in {1..7}; do
    echo -n "#"
    sleep 0.5  # Adjust this value to make it faster or slower
done
echo ")"

# --- Launch Prompt ---
echo "selmux v1 launched beta"
read -p "say or print “1” to launch 🚀: " choice

if [ "$choice" == "1" ]; then
    echo "Launching..."
    # Add your launch command or script call here
else
    echo "Launch cancelled."
fi
