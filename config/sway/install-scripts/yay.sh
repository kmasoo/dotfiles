#!/bin/bash

# Installs yay (AUR helper)

set -e

log_message "${INFO} Checking yay installation..."

if ! command -v yay &> /dev/null; then
  log_message "${YELLOW}Installing yay...${RESET}"
  git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin || handle_error "Failed to clone yay-bin repository"
  cd /tmp/yay-bin
  makepkg -si --noconfirm || handle_error "Failed to make and install yay-bin"
  cd -
  rm -rf /tmp/yay-bin

  log_message "${SUCCESS} Yay installed successfully"
else
  log_message "${INFO} Yay is already installed"
fi

