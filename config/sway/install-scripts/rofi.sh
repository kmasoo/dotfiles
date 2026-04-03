#!/bin/bash

# Installs rofi

set -e

log_message "${YELLOW}Installing rofi-wayland...${RESET}"

# Check if rofi (not rofi-wayland) is installed
if pacman -Qe rofi &>/dev/null && ! pacman -Qe rofi-wayland &>/dev/null; then
    log_message "${YELLOW}Uninstalling rofi due to conflict with rofi-wayland...${RESET}"
    sudo pacman -R --noconfirm rofi || handle_error "Failed to uninstall rofi"
fi

sudo pacman -S --noconfirm rofi-wayland || handle_error "Failed to install rofi-wayland"

log_message "${SUCCESS} Rofi installed successfully!"



