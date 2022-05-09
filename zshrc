# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Themes that we like - (jonathan, agnoster, re5et)
ZSH_THEME="re5et"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ubuntu zsh-vim-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

export SAVEHIST=100000

# export MANPATH="/usr/local/man:$MANbinPATH"TH


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Change default editor to vim
export EDITOR=/usr/bin/vim

export DOTFILES_DIR=~/Code/dotfiles

function commit_dot_files() {
	cd $DOTFILES_DIR && git add --all && git commit -am "modified $1" && cd -
}


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases

# UI edits
alias zshconfig="vim ~/.zshrc && source ~/.zshrc && commit_dot_files 'zsh config'"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias polybarconfig="vim ~/.config/polybar/config.ini && commit_dot_files 'polybar config'"
alias i3config="vim ~/.config/i3/config && commit_dot_files 'i3 config'"
alias dunstconfig="vim ~/.config/dunst/dunstrc && systemctl restart --user dunst && commit_dot_files 'dunst config'"
alias xresources="vim ~/.Xresources && xrdb ~/.Xresources && commit_dot_files 'Xresources'"
alias vimrc="vim ~/.vimrc && commit_dot_files 'vimrc'"
alias tmuxrc="vim ~/.tmux.conf && commit_dot_files 'tmux'"

# Git alias
alias gbd='git branch --merged | grep -i -v -E "master"| xargs git branch -d'

# Other handy aliases
alias gitlog="git log --all --decorate --oneline --graph"
alias open="xdg-open"
alias dc="docker-compose"
alias list_open_ports="netstat -lntu"
alias list_open_ports_with_processes="sudo netstat -tlnp"

# Jupyter fun times

alias jupyter_mode_activate='source ~/bin/jypter_env/bin/activate'
alias jupyter_start_note_book='jupyter_mode_activate && jupyter notebook'
init_notebook() {
    cd ~/bin/jypter_env
    jupyter_mode_activate
    jupyter_start_note_book
}


# Gataca aliases
alias gtcgo="cd ~/Code/go/src/github.com/gattaca"
alias gtcdefi="cd ~/Code/defi"
alias paladin="cd ~/Code/go/src/github.com/PaladinNetwork"

function init_testnet() {
    gtcgo
    cd gtc-avalanche-network-runner
    rm -rf ~/.avalanchego && AVAXBUILDPATH=$GOPATH/src/github.com/ava-labs/avalanchego/build/avalanchego ./scripts/run.sh
}

# Set up neovim
# alias nvim="~/bin/nvim.appimage"

# My todos for the day
export TODO_DIR=~/Documents/todos
function todo()  { vim $TODO_DIR/the-big-todo.md }
alias todo_rice="vim $TODO_DIR/ricing-todo.md"
alias todo_productivity="vim $TODO_DIR/producivity-todo.md"

# helpful methods
is_running() { ps aux | grep $1 }
untar() { tar -xzvf $1 }
reset_keyboard() { sh ~/.profile }

# Way of searching through howdoi in terminal
function hdi(){ howdoi $* -c -n 5; }

# Sets the brightness for all connected monitors through xrandr
brightness() {xrandr | grep -E "\sconnected" | awk '{print $1}' | xargs -I {} xrandr --output {} --brightness $1 }



## Node stuff

# too add node version manager support
export NVM_DIR="/home/layz/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Initialize fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Turn zsh into vim mode
bindkey -v


# Go stuff!
export GOPATH=$HOME/Code/go
export GOBIN=$HOME/Code/go/bin
export PATH=/usr/local/go/bin:$GOBIN:$PATH
go env -w GOPATH=$GOPATH
go env -w GOBIN=$GOBIN

go_playground() {
    
    mkdir /tmp/goplayground
    cd /tmp/goplayground
    echo 'package main

import (
    "fmt"
)

func main() {
    fmt.Println("Hello, playground")
}' > main.go
    vim main.go
}

# IP stuff?
# Automatically gets your public ip address and copies it into the clipboard for use
whatsmyip() {
    dig +short myip.opendns.com @resolver1.opendns.com | clipboard
}

backspace_swapped() {
    echo "keycode 22 = slash; keycode 61 = BackSpace" | xmodmap -
}

backspace_normal() {
    echo "keycode 61  = slash; keycode 22 = BackSpace" | xmodmap -
}



# Specific for paladin network
init_paladin() {
    tmux new -s paladin_local
}

mount_pdn_store() {
    veracrypt /home/layz/crypts/paladin /media/veracrypt1
}

# Python stuff
alias activate="source venv/bin/activate"
export GOPRIVATE=github.com/m2m-architect


# Flatpak installation
PATH=/var/lib/flatpak/exports/bin:$PATH

export PATH="$PATH:/home/layz/.foundry/bin"
