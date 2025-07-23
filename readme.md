# Dotfiles

Personal dotfiles managed with GNU Stow for easy symlink management and modular installation.

## Quick Start

1. **Install GNU Stow**:
   ```bash
   # Ubuntu/Debian
   sudo apt install stow
   
   # Arch Linux  
   sudo pacman -S stow
   
   # macOS
   brew install stow
   ```

2. **Clone and install**:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ./stow-install.sh install
   ```

## Usage

The `stow-install.sh` script provides easy management of your dotfiles:

```bash
# Install all packages
./stow-install.sh install

# Install specific package
./stow-install.sh install nvim-stow

# List available packages  
./stow-install.sh list

# Uninstall a package
./stow-install.sh uninstall zsh

# Show help
./stow-install.sh help
```

## Available Packages

- **Shell**: `zsh`, `bash`, `tmux`, `git`
- **Editors**: `vim`, `nvim-stow` 
- **Terminals**: `alacritty-stow`
- **Window Managers**: `hypr-stow`, `i3-stow`, `sway-stow`
- **System**: `dunst-stow`, `picom-stow`, `polybar-stow`, `waybar-stow`
- **Tools**: `atuin-stow`, `bat-stow`, `btop-stow`, `rofi-stow`, `wofi-stow`
- **Other**: `x11`, `misc-stow`

## Manual Installation (Advanced)

If you prefer using Stow directly:

```bash
# Install individual packages
stow zsh
stow nvim-stow
stow hypr-stow

# Uninstall packages  
stow -D zsh
stow -D nvim-stow
```

## Legacy Installation

The old symlink-based installer is still available as `installer.sh`, but the Stow-based approach is recommended for better management.
