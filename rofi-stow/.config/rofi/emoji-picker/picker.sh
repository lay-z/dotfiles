emoji_file=~/.config/rofi/emoji-picker/emojis.txt
cat  $emoji_file | /bin/rofi -dmenu | awk '{print $NF}' | clipboard

