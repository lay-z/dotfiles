echo $1
echo $2
app=$2
msg=swaymsg
nag=swaynag

echo $app
$msg $1 focus

if [ $? -ne 0 ]; then
  notify-send --icon=gtk-info "Initializing" "Starting up $app" 
  success=$($msg exec $app | jq '.[0].success')
  if [ $success -ne "true" ]; then
    echo "failure: $output"
    notify-send "failure" $output
  fi
fi

if [ $? -ne 0 ]; then
  $nag -m "Could not automatically run the application. Does it exist?"
fi
  
