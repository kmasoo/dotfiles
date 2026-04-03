#!/bin/bash

# Upgrade dotfiles
# Any local changes are saved in git stash

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

# Exit if running as root
if [ "$EUID" -eq 0 ]; then
    echo "${ERROR} Do not run this script as root. Aborting..." >&2
    exit 1
fi

# Create log directory
LOG_DIR="$HOME/swaydots-log-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$LOG_DIR"

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

cat << EOF
${YELLOW}
█▀▀ █ █ █▀█ █ █ █▀▄ █▀█ ▀█▀ █▀▀
▀▀█ █▄█ █▀█  █  █ █ █ █  █  ▀▀█
▀▀▀ ▀ ▀ ▀ ▀  ▀  ▀▀  ▀▀▀  ▀  ▀▀▀
${BLUE}	   @aceydot
${RESET}
EOF

log_message "${INFO} Starting dotfiles upgrade..."

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

if [ ! -d "$HOME/.config/sway" ] || [ ! -f "$HOME/.config/sway/.git/config" ]; then
    handle_error "Dotfiles repository not found at $HOME/.config/sway. Please install the dotfiles first."
fi

cd "$HOME/.config/sway"

# Save any changes
if ! git diff-index --quiet HEAD --; then
    log_message "${WARN} You have uncommitted changes. Saving them to git stash..."
    git stash
    log_message "${SUCCESS} Changes saved to git stash"
fi

# Get the newest packages
log_message "${YELLOW}Installing the newest packages...${RESET}"
if ! ~/.config/sway/install-scripts/packages.sh; then
    handle_error "Package installation failed!"
fi
log_message "${SUCCESS} Packages installed successfully!"

# Pull the latest changes
log_message "${YELLOW}Pulling latest changes...${RESET}"
if git pull; then
    log_message "${SUCCESS} Successfully updated dotfiles!"
    log_message "${NOTICE} If you had changes, they are saved in git stash"
else
    handle_error "Failed to pull latest changes. Please resolve conflicts manually."
fi

log_message "${GREEN}✨ Upgrade complete!${RESET}"

cat << EOF
${YELLOW}
█▀▀ █ █ █▀█ █ █ █▀▄ █▀█ ▀█▀ █▀▀
▀▀█ █▄█ █▀█  █  █ █ █ █  █  ▀▀█
▀▀▀ ▀ ▀ ▀ ▀  ▀  ▀▀  ▀▀▀  ▀  ▀▀▀
${BLUE}	   @aceydot
${RESET}
EOF
