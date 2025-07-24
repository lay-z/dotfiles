#!/bin/bash
##################################################
# GNU Stow Dotfiles Installer
# This script uses GNU Stow to manage dotfile symlinks
##################################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════╗"
    echo "║        GNU Stow Dotfiles Manager     ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${NC}"
}

check_stow() {
    if ! command -v stow &> /dev/null; then
        error "GNU Stow is not installed!"
        info "Please install it with:"
        info "  Ubuntu/Debian: sudo apt install stow"
        info "  Arch Linux: sudo pacman -S stow"
        info "  macOS: brew install stow"
        exit 1
    fi
    info "GNU Stow is installed ✓"
}

# Available packages
PACKAGES=(
    "zsh"           # ZSH shell configuration
    "bash"          # Bash shell configuration  
    "tmux"          # Terminal multiplexer
    "vim"           # Vim editor
    "git"           # Git configuration
    "x11"           # X11/Xresources
    "alacritty-stow" # Alacritty terminal
    "nvim-stow"     # Neovim editor
    "hypr-stow"     # Hyprland compositor
    "i3-stow"       # i3 window manager
    "sway-stow"     # Sway compositor
    "atuin-stow"    # Shell history
    "bat-stow"      # Better cat
    "btop-stow"     # System monitor
    "dunst-stow"    # Notifications
    "picom-stow"    # X11 compositor
    "polybar-stow"  # Status bar
    "redshift-stow" # Blue light filter
    "rofi-stow"     # Application launcher
    "waybar-stow"   # Wayland status bar
    "wofi-stow"     # Wayland launcher
    "misc-stow"     # Miscellaneous configs
)

show_packages() {
    info "Available packages:"
    for pkg in "${PACKAGES[@]}"; do
        if [ -d "$pkg" ]; then
            echo "  • $pkg"
        fi
    done
}

install_package() {
    local package="$1"
    
    if [ ! -d "$package" ]; then
        error "Package '$package' not found!"
        return 1
    fi

if [[ ! " ${PACKAGES[@]} " =~ " ${package} " ]]; then
      error "Not a stowable package!"
      return 1
    fi
    
    info "Installing package: $package"
    
    if stow "$package" -t ~; then
        info "✓ Successfully installed $package"
    else
        error "✗ Failed to install $package"
        warning "There might be conflicting files. Use 'stow --adopt $package' to adopt existing files."
        return 1
    fi
}

uninstall_package() {
    local package="$1"
    
    info "Uninstalling package: $package"
    
    if stow -D "$package" -t ~; then
        info "✓ Successfully uninstalled $package"
    else
        error "✗ Failed to uninstall $package"
        return 1
    fi
}

install_all() {
    info "Installing all available packages..."
    
    for package in "${PACKAGES[@]}"; do
        if [ -d "$package" ]; then
            install_package "$package"
        fi
    done
}

backup_existing() {
    local backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    info "Creating backup directory: $backup_dir"
    mkdir -p "$backup_dir"
    
    # This is a placeholder - in practice, you'd check for existing files
    # and move them to the backup directory before stowing
    warning "Manual backup recommended before first install"
}

show_help() {
    banner
    echo "Usage: $0 [COMMAND] [PACKAGE]"
    echo ""
    echo "Commands:"
    echo "  install [PACKAGE]    Install a specific package (or all if no package specified)"
    echo "  uninstall [PACKAGE]  Uninstall a specific package"
    echo "  list                 List available packages"
    echo "  help                 Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 install nvim-stow     # Install Neovim config"
    echo "  $0 install               # Install all packages"
    echo "  $0 uninstall zsh         # Uninstall ZSH config"
    echo "  $0 list                  # Show available packages"
    echo ""
}

main() {
    # Change to dotfiles directory
    cd "$(dirname "$0")"
    
    case "${1:-help}" in
        "install")
            check_stow
            if [ -n "$2" ]; then
                install_package "$2"
            else
                install_all
            fi
            ;;
        "uninstall")
            check_stow
            if [ -n "$2" ]; then
                uninstall_package "$2"
            else
                error "Please specify a package to uninstall"
                exit 1
            fi
            ;;
        "list")
            show_packages
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            error "Unknown command: $1"
            show_help
            exit 1
            ;;
    esac
}

banner
main "$@"
