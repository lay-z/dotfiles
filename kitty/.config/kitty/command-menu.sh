#!/usr/bin/env bash
# Kitty command menu - triggered by Ctrl+Right-click
# Displays zsh history via fzf with action menu

set -euo pipefail

HISTFILE="${HISTFILE:-$HOME/.zsh_history}"

# Read history from zsh history file, decode and deduplicate
# zsh history format: : timestamp:0;command
selected_cmd=$(
  cat "$HISTFILE" 2>/dev/null | \
  sed 's/^: [0-9]*:[0-9]*;//' | \
  tac | \
  awk '!seen[$0]++' | \
  fzf --height=100% --prompt="Command: " --header="Select a command (ESC to cancel)"
) || exit 0

[[ -z "$selected_cmd" ]] && exit 0

# Show action menu
action=$(
  printf "Rerun command\nCopy to clipboard\nEdit in nvim\nRun with sudo\nEdit inline" | \
  fzf --height=100% --prompt="Action: " --header="$selected_cmd"
) || exit 0

case "$action" in
  "Rerun command")
    echo -e "\033[1;32m▶ Running:\033[0m $selected_cmd"
    echo "─────────────────────────────────────────"
    eval "$selected_cmd"
    echo -e "\n\033[1;33m[Press Enter to close]\033[0m"
    read -r
    ;;
  "Copy to clipboard")
    echo -n "$selected_cmd" | wl-copy
    echo -e "\033[1;32m✓ Copied to clipboard:\033[0m $selected_cmd"
    sleep 1
    ;;
  "Edit in nvim")
    tmpfile=$(mktemp /tmp/kitty-cmd-XXXXXX.sh)
    echo "$selected_cmd" > "$tmpfile"
    nvim "$tmpfile"
    if [[ -s "$tmpfile" ]]; then
      edited_cmd=$(cat "$tmpfile")
      if [[ -n "$edited_cmd" ]]; then
        echo -e "\033[1;32m▶ Running:\033[0m $edited_cmd"
        echo "─────────────────────────────────────────"
        eval "$edited_cmd"
        echo -e "\n\033[1;33m[Press Enter to close]\033[0m"
        read -r
      fi
    fi
    rm -f "$tmpfile"
    ;;
  "Run with sudo")
    echo -e "\033[1;32m▶ Running with sudo:\033[0m $selected_cmd"
    echo "─────────────────────────────────────────"
    sudo bash -c "$selected_cmd"
    echo -e "\n\033[1;33m[Press Enter to close]\033[0m"
    read -r
    ;;
  "Edit inline")
    # Send command to the original kitty window for editing on the prompt
    kitty @ send-text --match recent:1 "$selected_cmd"
    ;;
esac
