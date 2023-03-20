echo $1
swaymsg $1 focus

if [ $? -ne 0 ]; then
  swaynag -m "Could not automatically switch to application. Is it running?"
fi
  
