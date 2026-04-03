#!/usr/bin/env bash
# Rofi clipboard using wl-clipboard

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/clipboard_history"
MAX_ITEMS=50

mkdir -p "$(dirname "$HISTFILE")"
touch "$HISTFILE"

# Add new clipboard entry
add_clipboard_entry() {
    local text
    text=$(wl-paste --no-newline)
    [[ -z "$text" ]] && exit 0
    # Remove if already exists, then add to top
    grep -Fxv "$text" "$HISTFILE" > "$HISTFILE.tmp"
    mv "$HISTFILE.tmp" "$HISTFILE"
    echo "$text" >> "$HISTFILE"
    # Keep only last $MAX_ITEMS
    tail -n "$MAX_ITEMS" "$HISTFILE" > "$HISTFILE.tmp"
    mv "$HISTFILE.tmp" "$HISTFILE"
}

# Select from history
select_clipboard_entry() {
    local selection
    selection=$(tac "$HISTFILE" | rofi -dmenu -i -p "Clipboard")
    [[ -n "$selection" ]] && echo -n "$selection" | wl-copy
}

case "$1" in
    add)
        add_clipboard_entry
        ;;
    menu)
        select_clipboard_entry
        ;;
    *)
        echo "Usage: $0 {add|menu}"
        exit 1
        ;;
esac
