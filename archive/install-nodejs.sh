#!/bin/bash

# Check for sudo privileges
if [ "$(id -u)"!= "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install pre-requisite packages
echo "Installing pre-requisite packages..."
sudo apt-get update
sudo apt-get install -y software-properties-common

# List of packages to install
declare -a PKGS=("nodejs" "npm" "package3")

# Function to check if a package is installed
function is_installed() {
    dpkg -s "$1" > /dev/null 2>&1
}

# Loop through the array and install packages if not already installed
for pkg in "${PKGS[@]}"; do
    if! is_installed "$pkg"; then
        echo "Installing $pkg..."
        sudo apt-get install -y "$pkg"
    else
        echo "$pkg is already installed."
    fi
done

echo "Installation completed."
