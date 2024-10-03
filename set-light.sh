# Nvim
sed -i "s/dark/light/g" ~/Code/dotfiles/nvim/lua/layz/config.lua

# Bat highlighting
LIGHT_THEME="OneHalfLight"
sed -i "s/\(--theme=\"\).*\"/\1$LIGHT_THEME\"/g" ~/.config/bat/config

# Update the hyprpanel theme
ags -r "useTheme('$HOME/.config/ags/themes/catppuccin_latte.json')"

# Update foot terminal
FOOT_CONFIG_DIR=~/.config/hypr/foot
ln -sf $FOOT_CONFIG_DIR/colors-cattpuccin-latte.ini $FOOT_CONFIG_DIR/colors.ini

gsettings set org.gnome.desktop.interface gtk-theme Arc-Lighter && gsettings set org.gnome.desktop.interface color-scheme "prefer-light"

