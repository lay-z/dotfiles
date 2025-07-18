#TODO work out if we can have one script to run all chrome apps from here
#!/bin/sh
if [ -z "$XDG_SESSION_TYPE" ]; then
    SESSION_TYPE=$(loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') -p Type --value)
else
    SESSION_TYPE=$XDG_SESSION_TYPE
fi

if [[ "$SESSION_TYPE" == "wayland" ]]; then
    # TODO figure out if we can just add wayland flags and then open them up
    #
    firefox -P "whatsapp" web.whatsapp.com
else
    google-chrome-stable --force-device-scale-factor=1.5 --user-data-dir=$HOME/.config/google-chrome-stable-for-whatsapp/ --app=https://web.whatsapp.com
fi
