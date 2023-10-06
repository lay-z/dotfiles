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



########## Variables

dir=$(pwd)                        # dotfiles directory
echo $dir
olddir=~/dotfiles_old             # old dotfiles backup directory
config_dir=~/.config
shell_config="bashrc vimrc zshrc oh-my-zsh Xresources fzf.zsh fzf"    # list of files/folders to symlink in homedir
ui_config="i3 polybar dunst redshift"


##########

# First initialize submodules
echo "Updating submodules"
git submodule update --init --recursive
echo "...done"

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

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
