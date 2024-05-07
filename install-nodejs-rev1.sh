#!/bin/bash

set -Eeuo pipefail

is_user_root() { [ "${EUID:-$(id -u)}" -eq 0 ]; }

# Check for sudo privileges
if is_user_root; then
    echo "You are the almighty root!"
else
    echo "This script must be run as root." >&2
    exit 1
fi

# Install pre-requisite packages
echo "Installing pre-requisite packages..."
sudo apt-get update
sudo apt-get install -y software-properties-common

# List of applications to install
declare -a PKGS=("nodejs" "npm")

# Function to install packages
install_packages() {
    for pkg in "${PKGS[@]}"; do
        if ! dpkg -s "$pkg" > /dev/null 2>&1; then
            echo "Installing $pkg..."
            sudo apt-get install -y "$pkg"
        else
            echo "$pkg is already installed."
        fi
    done
}

# Call the function to install packages
install_packages

# Automatically answer 'yes' to prompts
yes | sudo apt-get -y install

sudo npm install -g pnpm

echo "Installation completed."
