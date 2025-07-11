#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# TODO make a list of programs that i should have installed, and also install them. for now just keep track of them as list
# howdoi 	# pip install howdoi
# polybar # TODO how to install - apt install polybar?
# i3wm  	# apt install i3wm?
# vim	# apt install vim
# git	# apt install git
# nvm	# node version manager - some script
# uxrvt	# apt install uxrvt?
# fzf	# TODO?
# dunst notiications
# redshift
# google-chrome # apt install google-chrome?

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info() {
  echo -e "${GREEN}$1${NC} "
}

warning() {
  echo -e "${YELLOW}$1${NC} "
}

error() {
  echo -e "${RED}$1${NC} "
}

info "This is an informational message."
warning "This is a warning message."
error "This is an error message."

run() {
  local cmd="$@"
  local output
  local exit_status

  output=$(eval "$cmd" 2>&1)
  exit_status=$?

  if [ $exit_status -ne 0 ]; then
    error "[ERROR] Failed to execute command: $cmd"
    error "Error output:"
    error "$output"
    return $exit_status
  else
    info "succcesfully ran $cmd"
  fi

  return 0
}

test() {
 echo "we printing this out to stream"; exit 0   
}

run test


########## Variables

### TODO switch this to use stow instead will make the installation so much easier
dir=$(pwd)                        # dotfiles directory
echo $dir
olddir=~/dotfiles_old             # old dotfiles backup directory
config_dir=~/.config
shell_config="zshrc oh-my-zsh Xresources fzf.zsh fzf tmux.conf"    # list of files/folders to symlink in homedir
ui_config="i3 polybar dunst redshift"

install_oh_my_zsh() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

copy_over_config_files

##########
install() {
    # First initialize submodules
    info "Updating submodules"
    run git submodule update --init --recursive
    echo "...done"

    # create dotfiles_old in homedir
    info "Creating $olddir for backup of any existing dotfiles in ~"
    run mkdir -p $olddir
    info "...done"

    # change to the dotfiles directory
    info "Changing to config direcotry ($dir)"
    run cd $dir
    info "...done"

    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
    for file in $shell_config; do
        echo "Moving any existing dotfiles from ~ to $olddir"
        mv ~/.$file ~/dotfiles_old/
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    done

    for file in $ui_config; do
        echo "Moving any existing dotfiles from $config_dir to $olddir"
        mv $config_dir/$file ~/dotfiles_old/
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file $config_dir/$file
    done
}
