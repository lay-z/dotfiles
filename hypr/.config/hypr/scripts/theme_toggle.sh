#!/usr/bin/env bash

## Theme Toggle Script
## Toggles between default (dark) and light themes
## Also returns appropriate icon for waybar display

DIR="$HOME/.config/hypr"
CURRENT_THEME="$DIR/theme/current.bash"
DEFAULT_THEME="$DIR/theme/default.bash"
LIGHT_THEME="$DIR/theme/default_light.bash"

# Function to detect current theme by comparing with default themes
get_current_theme() {
    if [[ -f "$CURRENT_THEME" ]]; then
        # Compare current theme with default theme (ignoring comments and wallpaper)
        if cmp -s <(grep -v '^#\|^wallpaper' "$CURRENT_THEME") <(grep -v '^#\|^wallpaper' "$DEFAULT_THEME" 2>/dev/null); then
            echo "default"
        elif cmp -s <(grep -v '^#\|^wallpaper' "$CURRENT_THEME") <(grep -v '^#\|^wallpaper' "$LIGHT_THEME" 2>/dev/null); then
            echo "light"
        else
            # If we can't determine, assume default
            echo "default"
        fi
    else
        echo "default"
    fi
}

# Function to get icon based on current theme
get_icon() {
    current=$(get_current_theme)
    if [[ "$current" == "light" ]]; then
        echo "🌞"  # Sun icon for light theme (switch is "on" for light)
    else
        echo "🌙"  # Moon icon for dark theme (switch is "off" for light)
    fi
}

# Main logic
case "$1" in
    --toggle)
        current=$(get_current_theme)
        if [[ "$current" == "light" ]]; then
            # Switch to default (dark)
            "$DIR/theme/theme.sh" --default
        else
            # Switch to light
            "$DIR/theme/theme.sh" --light
        fi
        ;;
    --json)
      icon=$(get_icon)
      current=$(get_current_theme)
      printf '{"text":"%s","tooltip":"%s", "class": "%s"}' $icon $current
        ;;
    *)
        echo "Usage: $0 {--toggle|--icon|--status}"
        echo "  --toggle: Toggle between default and light themes"
        echo "  --json: Get current theme status in json format for waybar"
        exit 1
        ;;
esac
