# AGENTS.md

## Repository Overview

This is a dotfiles repository for Hyprland (Wayland compositor). Not a traditional software project - it contains configuration files and scripts for the entire Wayland ecosystem used daily.

## Wayland Services Configured

All configurations are managed within this directory and automatically linked to `~/.config`:

- **Hyprland**: Main window compositor config (`hyprland.conf`)
- **Waybar**: Status bar (config in `waybar/`)
- **Mako**: Notification daemon (config in `mako/`)
- **Rofi**: Application launcher/menu (configs in `rofi/`)
- **Kitty**: Terminal emulator (configs in `kitty/`)
- **Hypridle**: Idle/inactivity management (powersaving, screen lock)
- **Hyprlock**: Screen lock configuration
- **Wlogout**: Power menu/logout screen
- **Scripts**: Utility scripts in `scripts/`

## Configuration Structure

- **Theme system**: `theme/theme.sh` manages colors across all apps
- **Startup**: `scripts/startup` launches all services on Hyprland start
- **Colors**: Shared via `theme/current.bash` sourced by theme script
- **Monitors**: `monitors.conf` for display setup
- **Keybindings**: Defined in `hyprland.conf` with variables pointing to scripts

## Code Style Guidelines

### Config Files (.conf, .conf.d)
- Use sections with `#-- Section Name ----` separators
- Variable declarations use `$VAR_NAME` format
- Group related options, add blank lines between groups

### Bash Scripts
- Use `#!/usr/bin/env bash` shebang
- Double bracket `[[ ]]` for conditionals
- Functions named `verb_noun` pattern (e.g., `apply_wallpaper`)
- Quote all variables: `"$VAR"`, `"${VAR}"`
- Use `set -euo pipefail` for scripts expecting error handling
- Exit on missing dependencies with user-facing errors

### Keybinding Patterns
- Modifier keys: `SUPER`, `SUPER_SHIFT`, `CTRL_ALT`, `ALT`
- Direction keys: `h`/`l` (left/right), `k`/`j` (up/down)
- Pattern: `bind = MODIFIER, KEY, ACTION`
- Use variables for script paths (e.g., `$kitty`, `$rofi_launcher`)

### Window Rules
- Use `windowrule` blocks with `name` and `match` fields
- Common rules: `float`, `size`, `center`, `animation`
- Match by: `class`, `title`, `float` classes (e.g., `kitty-float`)

## Theme Variables

The theme system uses color variables (available in `theme/current.bash`):
- `$background`, `$foreground`
- `$color0` through `$color15` (black to white)
- `$accent` (primary accent color)
- `modbackground[]` array for alternative background shades

Apply themes by running: `bash ~/.config/hypr/theme/theme.sh --default` (dark), `--light`, or `--pywal` (from wallpaper)

## File-Specific Notes

### Hyprland Config
- Sources: `hyprtheme.conf` (colors), `hyprpowerprofile.conf` (performance)
- Monitor setup in separate `monitors.conf` file
- Workspace 5 is designated as "AI workspace" (bind to SUPER+a)

### Waybar
- Config in `waybar/config`, styling in `waybar/style.css`
- Modules defined in `waybar/modules` (includes `custom/spotify`)

### Kitty Terminal
- Uses Catppuccin theme system via `kitty +kitten themes`
- Configuration split: `kitty.conf`, `fonts.conf`, `colors.conf`

## Testing/Validation

No formal test suite. Validate configs by:
- Reloading Hyprland: `hyprctl reload`
- Restarting services: `pkill waybar && ~/.config/hypr/scripts/statusbar`
- Checking config syntax: app-specific tools (e.g., `kitty --config`)

## Common Operations

- Apply new theme: `bash ~/.config/hypr/theme/theme.sh --default`
- Restart bar: `pkill waybar && ~/.config/hypr/scripts/statusbar &`
- Lock screen: `hyprlock`
- Screenshot: `grim -g "$(slurp)" - | wl-copy` (also scripts in `scripts/screenshot`)