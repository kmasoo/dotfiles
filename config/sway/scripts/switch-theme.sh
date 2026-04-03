#!/usr/bin/env bash
set -e

CONFIG_DIR="$HOME/.config"
SWAY_DIR="$CONFIG_DIR/sway"
THEMES_DIR="$SWAY_DIR/themes"
theme="$1"
theme_dir="$THEMES_DIR/$theme"
THEME_GTK_DIR="$theme_dir/gtk"

if [ ! -d "$theme_dir" ]; then
    notify-send "❌ Theme not found: $theme"
    exit 1
fi

# Waybar
if [ -f "$theme_dir/waybar/style.css" ]; then
    ln -sf "$theme_dir/waybar/style.css" "$CONFIG_DIR/waybar/style.css"
fi
if [ -f "$theme_dir/waybar/config" ]; then
    ln -sf "$theme_dir/waybar/config" "$CONFIG_DIR/waybar/config"
fi

# Rofi
if [ -f "$theme_dir/rofi/$theme.rasi" ]; then
    sed -i "s|^@theme \".*\"|@theme \"$theme_dir/rofi/$theme.rasi\"|" "$CONFIG_DIR/rofi/config.rasi"
fi

# Swaylock
if [ -f "$theme_dir/swaylock/config" ]; then
    ln -sf "$theme_dir/swaylock/config" "$CONFIG_DIR/swaylock/config"
fi

# Sway
if [ -f "$theme_dir/sway/config-$theme" ]; then
    sed -i "s|^include .*/sway/themes/.*/sway/config-.*|include $theme_dir/sway/config-$theme|" "$SWAY_DIR/config"
fi

# SwayNC
if [ -f "$theme_dir/swaync/style.css" ]; then
    ln -sf "$theme_dir/swaync/style.css" "$CONFIG_DIR/swaync/style.css"
fi

# Starship
if [ -f "$theme_dir/starship/starship.toml" ]; then
    ln -sf "$theme_dir/starship/starship.toml" "$CONFIG_DIR/starship.toml"
fi

# Alacritty
theme_import="$theme_dir/alacritty/$theme.toml"
if [ -f "$theme_dir/alacritty/$theme.toml" ]; then
    sed -i "s|^general\.import = .*|general.import = [\"$theme_import\"]|" "$CONFIG_DIR/alacritty/alacritty.toml"
fi

# Fastfetch
if [ -f "$theme_dir/fastfetch/ascii.ansi" ]; then
    ln -sf "$theme_dir/fastfetch/ascii.ansi"   "$CONFIG_DIR/fastfetch/ascii.ansi"
fi
if [ -f "$theme_dir/fastfetch/config.jsonc" ]; then
    ln -sf "$theme_dir/fastfetch/config.jsonc" "$CONFIG_DIR/fastfetch/config.jsonc"
fi

# This is a pretty stupid method for changing GTK themes, but it's the only one i found that actually works

# GTK4
if [ -d "$THEME_GTK_DIR/gtk-4.0" ]; then
    rm -rf "$HOME/.config/gtk-4.0"
    ln -s "$THEME_GTK_DIR/gtk-4.0" "$HOME/.config/gtk-4.0"
fi

# GTK3
if [ -d "$THEME_GTK_DIR/gtk-3.0" ]; then
    rm -rf "$HOME/.config/gtk-3.0"
    ln -s "$THEME_GTK_DIR/gtk-3.0" "$HOME/.config/gtk-3.0"
fi

# Reload
if [ -n "$WAYLAND_DISPLAY" ] && pgrep -x sway >/dev/null; then
    if pgrep swaync >/dev/null; then
        killall swaync
    fi

    swaymsg reload

    notify-send "🎨 Theme switched to $theme"
fi

