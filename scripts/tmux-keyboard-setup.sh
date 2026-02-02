#!/bin/bash

# Script to attach to tmux session, start server if needed, wait for restore, 
# and create/attach to 'keyboard' session with xremap

set -e

echo "Starting tmux keyboard setup..."

# Check if tmux server is running
if ! tmux has-session 2>/dev/null; then
    echo "No tmux server running. Starting tmux server..."

    
    # Wait for tmux restore to complete if using tmux-resurrect or similar
    echo "Waiting for tmux restore to complete..."
    sleep 10
    
    # Check for common restore indicators
    while pgrep -f "tmux.*restore" > /dev/null 2>&1; do
        echo "Waiting for tmux restore process to finish..."
        sleep 1
    done
fi

tmux attach
