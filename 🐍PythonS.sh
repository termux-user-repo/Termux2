#!/bin/bash

# --- AUTO DEPENDENCY INSTALLER ---
echo "Checking system environment..."

# Function to install python dependencies
install_deps() {
    echo "[!] Installing/Updating python dependencies..."
    # Use --break-system-packages for modern distros, or user-local install
    if python3 -m pip install --upgrade pip &> /dev/null; then
        python3 -m pip install requests --break-system-packages &> /dev/null || python3 -m pip install --user requests
    else
        echo "[!] Warning: Could not auto-install requests. Please run: pip install requests"
    fi
}

if ! command -v python3 &> /dev/null; then
    echo "[!] python3 not found. Please install it via your system package manager."
    exit 1
fi

# Ensure requests is available
if ! python3 -c "import requests" &> /dev/null; then
    install_deps
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
    idx = 0
    while time.time() < end_time:
        sys.stdout.write(f'\r{message} {symbols[idx % len(symbols)]} ')
        sys.stdout.flush()
        time.sleep(0.1)
        idx += 1
    sys.stdout.write('\r' + ' ' * (len(message) + 10) + '\r')
    sys.stdout.flush()

def fetch_local_data():
    if not requests:
        print("\n[!] Error: 'requests' module is missing.")
        return None
    try:
        response = requests.get("http://ip-api.com/json/", timeout=5)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        print(f"\n[!] Connection Error: {e}")
        return None

# --- MAIN EXECUTION ---
print("—" * 40)
print("\n      W E L C O M E   T O   🐍   p y t h o n S\n")
print("—" * 40)

spinning_cursor(2.0, "🐍 Python sys launching")

print("System initialized.")
print("—" * 40)

ascii_art = """
                _   _                 ____  
  _ __  _   _ _| |_| |__   ___  _ __ / ___| 
 | '_ \| | | | __| '_ \ / _ \| '_ \\___ \ 
 | |_) | |_| | |_| | | | (_) | | | |___) |
 | .__/ \__, |\__|_| |_|\___/|_| |_|____/ 
 |_|    |___/                             
"""
print(ascii_art)

while True:
    print("|—— 1: IP | 2: Geo | 3: Exit ——|")
    choice = input("|_ Choice: ").strip()
    
    if choice == "1":
        data = fetch_local_data()
        if data:
            print(f"\n>>> Your Public IP: {data.get('query')}\n")
    elif choice == "2":
        data = fetch_local_data()
        if data:
            print("\n>>> Current Geolocation Info:")
            for key in ['country', 'regionName', 'city', 'lat', 'lon', 'isp']:
                print(f"    {key.capitalize():<10}: {data.get(key)}")
            print("")
    elif choice == "3":
        print("Exiting...")
        break
    else:
        print("\n[!] Invalid input.\n")
EOF
