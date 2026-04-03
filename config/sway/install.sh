#!/bin/bash

# Install script for dotfiles

set -e

clear

# Colors
SUCCESS="$(tput setaf 2)[SUCCESS]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTICE="$(tput setaf 5)[NOTICE]$(tput sgr0)"
INFO="$(tput setaf 6)[INFO]$(tput sgr0)"
WARN="$(tput setaf 208)[WARNING]$(tput sgr0)"
PURPLE="$(tput setaf 5)"
BLUE="$(tput setaf 4)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
RESET="$(tput sgr0)"

export SUCCESS ERROR NOTICE INFO WARN PURPLE BLUE YELLOW GREEN RESET

# Exit if running as root
if [ "$EUID" -eq 0 ]; then
    echo "${ERROR} Do not run this script as root. Aborting..." >&2
    exit 1
fi

cat << EOF
${YELLOW}
█▀▀ █ █ █▀█ █ █ █▀▄ █▀█ ▀█▀ █▀▀
▀▀█ █▄█ █▀█  █  █ █ █ █  █  ▀▀█
▀▀▀ ▀ ▀ ▀ ▀  ▀  ▀▀  ▀▀▀  ▀  ▀▀▀
${BLUE}	   @aceydot
${RESET}
EOF

echo "${NOTICE} Before we get started: this script does not install any hardware stuff like NVIDIA drivers, network etc. It assumes you already handled that."

read -rp "Continue? (y/n): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "${ERROR} Aborted by user."
    exit 1
fi

# Create log directory
LOG_DIR="$HOME/swaydots-log-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$LOG_DIR"
export LOG_DIR

# Logging
log_message() {
    local script_name=$(basename "${BASH_SOURCE[1]}" .sh)
    local log_file="$LOG_DIR/${script_name}.log"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
    echo "$1"
}

# Error handling
handle_error() {
    local script_name=$(basename "${BASH_SOURCE[1]}" .sh)
    local log_file="$LOG_DIR/${script_name}.log"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $1" >> "$log_file"
    echo "${ERROR} $1" >&2
    exit 1
}

export -f log_message handle_error

DOTFILES_REPO="https://github.com/aceydot/swaydots.git"
CLONE_DIR="$HOME/.config/sway"
INSTALL_SCRIPTS_DIR="$HOME/.config/sway/install-scripts"
SCRIPTS_DIR="$HOME/.config/sway/scripts"

# Check if git is installed
if ! command -v git &>/dev/null; then
    log_message "${WARN} Git is not installed. Installing git..."
    sudo pacman -Sy --noconfirm git || handle_error "Failed to install git"
fi

set -e

# Backup existing dotfiles
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

log_message "${YELLOW}Backing up existing configs to $BACKUP_DIR...${RESET}"
mkdir -p "$BACKUP_DIR" || handle_error "Failed to create backup directory"

CONFIG_DIRS=(
    alacritty
    fastfetch
    gtk-3.0
    gtk-4.0
    rofi
    sway
    swaylock
    swaync
    waybar
)

CONFIG_FILES=(
    starship.toml
)

for cfg in "${CONFIG_DIRS[@]}"; do
    if [ -d "$HOME/.config/$cfg" ]; then
        log_message "${SUCCESS} Backed up $cfg"
        cp -r "$HOME/.config/$cfg" "$BACKUP_DIR/" || handle_error "Failed to backup $cfg"
    else
        log_message "${INFO} Config $cfg not found, skipping"
    fi
done

for cfg in "${CONFIG_FILES[@]}"; do
    if [ -f "$HOME/.config/$cfg" ]; then
        log_message "${SUCCESS} Backed up $cfg"
        cp "$HOME/.config/$cfg" "$BACKUP_DIR/" || handle_error "Failed to backup $cfg"
    else
        log_message "${INFO} Config $cfg not found, skipping"
    fi
done

log_message "${SUCCESS} Backup completed successfully"

# Clone the dotfiles
if [ -d "$CLONE_DIR" ]; then
  log_message "${INFO} Dotfiles directory already exists at $CLONE_DIR, removing its contents..."
   rm -rf "$CLONE_DIR"/* "$CLONE_DIR"/.[!.]*
fi
log_message "${YELLOW}Cloning dotfiles repository to $CLONE_DIR...${RESET}"
git clone --depth=1 "$DOTFILES_REPO" "$CLONE_DIR"

log_message "${SUCCESS} Cloning complete!"

cd "$INSTALL_SCRIPTS_DIR"

./default-configs.sh

./yay.sh

./packages.sh

./rofi.sh

./zsh.sh

log_message "${YELLOW}Applying the default theme: gruvbox-material-dark...${RESET}"
"$SCRIPTS_DIR/switch-theme.sh" "gruvbox-material-dark" || handle_error "Failed to switch theme"

if pgrep -x sway >/dev/null; then
    swaymsg reload
fi

log_message "${GREEN}✨ Installation complete! I’d recommend rebooting or logging out and back in.${RESET}"

cat << EOF
${YELLOW}
█▀▀ █ █ █▀█ █ █ █▀▄ █▀█ ▀█▀ █▀▀
▀▀█ █▄█ █▀█  █  █ █ █ █  █  ▀▀█
▀▀▀ ▀ ▀ ▀ ▀  ▀  ▀▀  ▀▀▀  ▀  ▀▀▀
${BLUE}	   @aceydot
${RESET}
EOF
