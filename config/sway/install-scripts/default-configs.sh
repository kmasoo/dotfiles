#!/bin/bash

# Creates all the necessary directories and symlinks needed config files

set -e

config_dir="$HOME/.config"
theme_dir="$HOME/.config/sway/default-configs"

log_message "${INFO} Symlinking default configs..."

# Create directories if they don't exist
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/rofi
mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/swaylock
mkdir -p ~/.config/waybar
mkdir -p ~/.config/swaync

log_message "${YELLOW}Symlinking alacritty.toml...${RESET}"

# alacritty.toml
ln -sf "$theme_dir/alacritty/alacritty.toml" "$config_dir/alacritty/alacritty.toml"

log_message "${YELLOW}Symlinking config.rasi (rofi)...${RESET}"

# config.rasi (rofi)
ln -sf "$theme_dir/rofi/config.rasi" "$config_dir/rofi/config.rasi"

log_message "${YELLOW}Symlinking config.json (swaync)...${RESET}"

# config.json (swaync)
ln -sf "$theme_dir/swaync/config.json" "$config_dir/swaync/config.json"

log_message "${SUCCESS} Default configs symlinked successfully!"
