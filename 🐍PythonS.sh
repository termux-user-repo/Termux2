#!/bin/bash

# --- AUTO DEPENDENCY INSTALLER ---
echo "Checking system environment..."
if ! command -v python3 &> /dev/null; then
    echo "[!] python3 not found. Installing automatically..."
    if command -v pkg &> /dev/null; then
        # Termux Environment
        pkg update -y && pkg install python python-pip -y
    elif command -v apk &> /dev/null; then
        # iSH / Alpine Environment
        apk update && apk add python3 py3-pip py3-requests
    else
        echo "[!] Unsupported system package manager. Please install python3 manually."
    fi
fi

# Try to ensure the requests library is available for API lookups
python3 -c "import requests" &> /dev/null
if [ $? -ne 0 ]; then
    echo "[!] Installing Python requests library..."
    pip install requests &> /dev/null || pkg install python-requests -y &> /dev/null || apk add py3-requests &> /dev/null
fi

# --- RUN THE INTERACTIVE SCRIPT ---
python3 - << 'EOF'
import sys
import time

try:
    import requests
except ImportError:
    requests = None

def spinning_cursor(duration, message=""):
    symbols = ['\\', '|', '/', '-']
    end_time = time.time() + duration
    while time.time() < end_time:
        for symbol in symbols:
            sys.stdout.write(f'\r{message} "{symbol}" ')
            sys.stdout.flush()
            time.sleep(0.1)
    # Clear line
    sys.stdout.write('\r' + ' ' * (len(message) + 15) + '\r')
    sys.stdout.flush()

def fetch_local_data():
    if not requests:
        print("\n[!] Error: 'requests' module is missing. Run pip install requests.")
        return None
    try:
        # Fetching current user's IP info securely via a public API
        response = requests.get("http://ip-api.com/json/", timeout=5)
        return response.json()
    except Exception as e:
        print(f"\n[!] Connection Error: {e}")
        return None

# --- STEP 1: Welcome Screen ---
print("—" * 40)
print("\n      W E L C O M E   T O   🐍   p y t h o n S\n")
print("—" * 40)

# --- STEP 2: First Launch Animation (Extended to 6 seconds) ---
spinning_cursor(6.0, "🐍 Python sys 2 launching")

# --- STEP 3: Downloads & Installer ---
print("USER İP GIVER DOWNLOAD...")
time.sleep(0.4)

print("Sys downloaded !")
time.sleep(0.2)
print("—" * 40)

# --- STEP 4: Secondary Launch (Extended to 4 seconds) ---
spinning_cursor(4.0, "Python system launching (——-)")

# --- STEP 5: ASCII Art ---
ascii_art = """
                _   _                 ____  
  _ __  _   _ _| |_| |__   ___  _ __ / ___| 
 | '_ \| | | | __| '_ \ / _ \| '_ \\___ \ 
 | |_) | |_| | |_| | | | (_) | | | |___) |
 | .__/ \__, |\__|_| |_|\___/|_| |_|____/ 
 |_|    |___/                             
"""
print(ascii_art)

# --- STEP 6: Interactive Menu System ---
while True:
    print("|—— 1 ip giver ——— 2 geo location giver ——|")
    print("\nBeta")
    sys.stdout.write("|_ ")
    sys.stdout.flush()
    choice = input().strip()
    
    if choice == "1":
        spinning_cursor(1.5, "Requesting Public IP...")
        data = fetch_local_data()
        if data:
            print(f"\n>>> Your Public IP: {data.get('query')}\n")
        print("—" * 40)
        
    elif choice == "2":
        spinning_cursor(1.5, "Locating Server Coordinates...")
        data = fetch_local_data()
        if data:
            print("\n>>> Current Geolocation Info:")
            print(f"    Country:   {data.get('country')} ({data.get('countryCode')})")
            print(f"    Region:    {data.get('regionName')}")
            print(f"    City:      {data.get('city')}")
            print(f"    Latitude:  {data.get('lat')}")
            print(f"    Longitude: {data.get('lon')}")
            print(f"    Provider:  {data.get('isp')}\n")
        print("—" * 40)
        
    else:
        print("\n[!] Invalid input. Choose Option 1 or 2.\n")
EOF
