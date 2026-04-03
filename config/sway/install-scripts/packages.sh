#!/bin/bash

# Installs necessary packages

set -e

# Update the system
log_message "${YELLOW}Updating system...${RESET}"
if ! sudo pacman -Syu --noconfirm; then
    handle_error "System update failed!"
fi

log_message "${INFO} Starting package installation..."

# You can customize this, but be careful, as this can and will break stuff.
pacman_packages=(
    alacritty
    fastfetch
    grim
    imagemagick
    noto-fonts-emoji
    otf-font-awesome
    playerctl
    rofimoji
    slurp
    starship
    sway
    swaybg
    swayidle
    swaylock
    swaync
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    waybar
    wl-clipboard
    zsh
)

log_message "${YELLOW}Installing pacman packages...${RESET}"

if ! sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"; then
    handle_error "Failed to install Pacman packages!"
fi

aur_packages=(
    clipton-git
    ttf-babelstone-runic
    wttrbar
)

log_message "${YELLOW}Installing AUR packages...${RESET}"

if ! yay -S --noconfirm "${aur_packages[@]}"; then
    handle_error "Failed to install AUR packages!"
fi

log_message "${YELLOW}Enabling clipton service...${RESET}"

if ! systemctl --user enable --now clipton; then
    handle_error "Failed to enable clipton service!"
fi

log_message "${SUCCESS} All packages installed successfully!${RESET}"

