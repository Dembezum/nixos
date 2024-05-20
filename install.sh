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

