#!/bin/bash

# Script to attach to tmux session, start server if needed, wait for restore, 
# and create/attach to 'keyboard' session with xremap

set -e

echo "Starting tmux keyboard setup..."

# Check if tmux server is running
if ! tmux has-session 2>/dev/null; then
    echo "No tmux server running. Starting tmux server..."
    tmux new-session -d -s temp
    tmux kill-session -t temp
    
    # Wait for tmux restore to complete if using tmux-resurrect or similar
    echo "Waiting for tmux restore to complete..."
    sleep 3
    
    # Check for common restore indicators
    while pgrep -f "tmux.*restore" > /dev/null 2>&1; do
        echo "Waiting for tmux restore process to finish..."
        sleep 1
    done
fi

# Try to attach to 'keyboard' session
if tmux has-session -t keyboard 2>/dev/null; then
    echo "Tmux has session no need to create"
else
    echo "Creating new 'keyboard' session..."
    tmux new-session -d -s keyboard
fi
    
# Send the xremap command to the session
echo "Executing xremap command in 'keyboard' session..."
tmux send-keys -t keyboard "xremap \$HOME/Code/dotfiles/xremap/config.yml" Enter

tmux attach -t keyboard
