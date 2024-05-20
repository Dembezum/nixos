#!/usr/bin/env bash

set -e

LOGFILE=".switch.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Function to log messages
log_message() {
    echo "$1" | tee -a "$LOGFILE"
    chmod 666 "$LOGFILE"  # Set log file permissions to rw-rw-rw-
}

# Ensure the script is not run as root
if [[ $EUID -eq 0 ]]; then
   log_message "This script should not be run as root. Please run it as a normal user."
   exit 1
fi

# Enable flakes in NixOS configuration
log_message "Enabling flakes in /etc/nixos/configuration.nix..."
CONFIG_FILE="/etc/nixos/configuration.nix"
FLAKE_SETTING="  experimental-features = [ \"nix-command\" \"flakes\" ];"

if ! grep -q 'nix.settings.experimental-features' "$CONFIG_FILE"; then
    if grep -q 'nix.settings' "$CONFIG_FILE"; then
        sudo sed -i "/nix.settings/a\\
$FLAKE_SETTING
" "$CONFIG_FILE"
    else
        sudo bash -c "echo -e '\nnix.settings = {\n$FLAKE_SETTING\n};\n' >> $CONFIG_FILE"
    fi
else
    log_message "Flakes are already enabled."
fi

# Apply the changes to NixOS configuration
log_message "Applying changes to NixOS configuration..."
sudo nixos-rebuild switch

# Check if home-manager is installed, if not install it
if ! command -v home-manager &> /dev/null; then
    log_message "Home Manager is not installed. Installing Home Manager..."
    nix run home-manager/master -- init --switch | tee -a "$LOGFILE"
    chmod 666 "$LOGFILE"  # Set log file permissions to rw-rw-rw-
else
    log_message "Home Manager is already installed."
fi

# Function to switch system configuration
switch_system() {
    log_message "Switching system configuration..."
    sudo nixos-rebuild switch --flake .#system | tee -a "$LOGFILE"
    chmod 666 "$LOGFILE"  # Set log file permissions to rw-r

