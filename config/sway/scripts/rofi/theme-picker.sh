#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/sway/themes"
SWITCHER="$HOME/.config/sway/scripts/switch-theme.sh"

declare -A ICONS=(
  [gruvbox-material-dark]="📻"
  [everforest-dark]="🌲"
  [rose-pine-dark]="🌹"
  [catppuccin-macchiato]="🐈‍⬛"
  [nord]="🏔️"
)

menu=$(for t in $(ls "$THEMES_DIR"); do
    echo -e "${ICONS[$t]}  $t"
done)

choice=$(echo "$menu" | rofi -dmenu -p "Select theme:")

theme=$(echo "$choice" | awk '{print $2}')

[ -n "$theme" ] && "$SWITCHER" "$theme"

