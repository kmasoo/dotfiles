#!/bin/bash

# Sets up zsh

set -e

log_message "${INFO} Checking current default shell..."

if [[ ! $SHELL == "/usr/bin/zsh" ]]; then
  log_message "${YELLOW}Setting zsh as default shell...${RESET}"
  chsh -s /usr/bin/zsh || handle_error "Failed to set zsh as default shell"
  log_message "${SUCCESS} Zsh set as default shell."
else
  log_message "${INFO} Zsh is already the default shell."
fi

touch ~/.zshrc
touch ~/.zsh_history

grep -qxF 'HISTFILE=~/.zsh_history' ~/.zshrc || {
    cat << 'EOF' >> ~/.zshrc

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
EOF
}

# Sets up starship
grep -qxF 'eval "$(starship init zsh)"' ~/.zshrc || \
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc

