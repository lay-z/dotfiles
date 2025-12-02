#!/bin/bash
# Correctly launches the correct application for the job
# Save this as ~/bin/twitter-handler.sh (or anywhere you prefer)

URL="$1"

notify-send $URL

if [[ "$URL" =~ (twitter\.com|x\.com) ]]; then
    echo "Handling Twitter URL: $URL"
    # Your custom logic here
    /home/layz/bin/zen --new-instance --new-window $URL -P xUser
elif [[ "$URL" =~ slack\.com ]] || [[ "$URL" =~ ^slack:// ]]; then
    echo "Handling Slack URL: $URL"
    # Convert slack:// protocol URLs to https://app.slack.com if needed
    if [[ "$URL" =~ ^slack:// ]]; then
        # Extract workspace and channel info and convert to web URL
        SLACK_WEB_URL="${URL/slack:\/\//https://app.slack.com/client/}"
        brave "$SLACK_WEB_URL"
    else
        brave "$URL"
    fi
else
    # Pass to default browser for non-Twitter URLs
    /home/layz/bin/zen --new-tab "$URL"
fi


