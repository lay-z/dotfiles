# Nvim
sed -i "s/light/dark/g" ~/Code/dotfiles/nvim/lua/layz/config.lua

# Bat highlighting
LIGHT_THEME="Dracula"
sed -i "s/\(--theme=\"\).*\"/\1$LIGHT_THEME\"/g" ~/.config/bat/config

# Update the hyprpanel theme
ags -r "useTheme('$HOME/.config/ags/themes/catppuccin_mocha.json')"

# Update foot terminal
FOOT_CONFIG_DIR=~/.config/hypr/foot
ln -sf $FOOT_CONFIG_DIR/colors-dark.ini $FOOT_CONFIG_DIR/colors.ini

gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Frappe && gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
