#!/bin/bash
# Correctly launches the correct application for the job
# Save this as ~/bin/twitter-handler.sh (or anywhere you prefer)

URL="$1"

if [[ "$URL" =~ (twitter\.com|x\.com) ]]; then
    echo "Handling Twitter URL: $URL"
    # Your custom logic here
    /home/layz/bin/zen --new-instance --new-window $URL -P xUser
else
    # Pass to default browser for non-Twitter URLs
    /home/layz/bin/zen --new-tab "$URL"
fi


