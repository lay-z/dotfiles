#!/bin/zsh

msg=swaymsg
nag=swaynag
notify=notify-send

default_controller=$(bluetoothctl list | grep default | awk '{print $2}') 
power_status=$(bluetoothctl show 74:E5:F9:EE:8B:43 | grep Powered | awk '{print $2}')
scan_status=$(bluetoothctl show 74:E5:F9:EE:8B:43 | grep Scan | awk '{print $2}')
# Figure out how to apend to list if power is set too off

echo $choices
if [[ $power_status == 'no' ]]; then
  choices="start"
else
  choices="shutdown\nconnect\nscan-devices\ndiscoverable off"
fi;

selected=$(echo $choices | /bin/rofi -dmenu)

echo $selected

case $selected in
  "shutdown")
    resp=$(bluetoothctl power off)
    $notify "Power Off" "powered off bluetooth device"
    ;;
  "start")
    resp=$(bluetoothctl power on)
    $notify "Power On" "powered on bluetooth device"
    ;;
  "connect")
    device=$(bluetoothctl devices | /bin/rofi -dmenu | awk '{print $2}') 

    bluetoothctl connect $device
    if [ $? -ne 0 ]; then
      $notify "Error" "Could not connect to bluetooth device"
    fi
    ;;
  "scan-devices")
    bluetoothctl scan on
    if [ $? -ne 0 ]; then
      $notify "Error" "Could not connect to bluetooth device"
    fi
    $notify "Success" "Scan initialized"
    bluetoothctl scan off
    ;;
  "discoverable off")
    bluetoothctl discoverable off
    bluetoothctl pairable off
    if [ $? -ne 0 ]; then
      $notify "Error" "Could not connect to bluetooth device"
    fi
    ;;
  "")
    echo "Cancelled OPTION"
    ;;
  *)
    $notify "Error" "Unknown Option: '$selected'"
    ;;
esac

   
