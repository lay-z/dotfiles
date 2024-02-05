# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/home/layz/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Themes that we like - (jonathan, agnoster, re5et)
ZSH_THEME="amuse"

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

#!/bin/bash

# Usage: clone_plugin <repo_url>
# Example: clone_plugin https://github.com/username/my-plugin.git
install_plug() {
    local repo_url="$1"
    local plugin_name=$(basename "$repo_url" .git)
    local plugins_dir="$HOME/.oh-my-zsh/custom/plugins"

    # Check if the plugin directory already exists
    if [ -d "$plugins_dir/$plugin_name" ]; then
        # echo "Plugin '$plugin_name' already exists in '$plugins_dir'. Skipping clone."
        return 1
    fi

    # Clone the repository
    git clone "$repo_url" "$plugins_dir/$plugin_name"

    if [ $? -ne 0 ]; then
        echo "Failed to clone plugin '$plugin_name'."
        return 1
    fi

    return 0
}

# make sure custom plugins are installed first
install_plug https://github.com/zsh-users/zsh-autosuggestions
install_plug https://github.com/zsh-users/zsh-syntax-highlighting
install_plug https://github.com/jeffreytse/zsh-vi-mode


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ubuntu zsh-autosuggestions zsh-syntax-highlighting colorize colored-man-pages zsh-vi-mode)

##### plugin configuration for colorize
ZSH_COLORIZE_STYLE="dracula"
ZSH_COLORIZE_TOOL=chroma

alias less=cless
# alias cat=ccat
alias cat=bat


# User configuration

# Save all the history for all time
export SAVEHIST=1000000000
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# TODO try to figure out a way to also share history with other machines

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
export EDITOR=nvim

export DOTFILES_DIR=~/Code/dotfiles

function commit_dot_files() {
    cd $DOTFILES_DIR && git add --all && git commit -am "modified $1" && cd -
}


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
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
alias swayconf="vim ~/.config/sway/config && commit_dot_files 'sway config updated'"
alias alacrittyconf="vim ~/.config/alacritty/alacritty.yml && commit_dot_files 'alacritty config updated'"
alias chromeapps="cd $DOTFILES_DIR/chrome-apps/"

# Cheatsheet
alias chtsh="CHTSH_QUERY_OPTIONS="style=perldoc" cht.sh"


# Other handy aliases
alias open="xdg-open"
alias list_open_ports="netstat -lntu"
alias list_open_ports_with_processes="sudo netstat -tlnp"


##################################################################################################
########################################## DOCKER THINGS #########################################
##################################################################################################


docker_started() {
    systemctl is-active --quiet docker || systemctl start docker
}


alias dc="docker_started && docker compose"
alias dcu="docker_started && docker compose up"
alias d="docker_started docker"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dst='docker stop $(docker ps -q)'
alias drm='docker rm $(dst)'


# Unclear if this is useful or not
docker_group(){
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
}



##################################################################################################
########################################### GIT THINGS ###########################################
##################################################################################################

# git aliases
alias gitlog="git log --all --decorate --oneline --graph"
# Git alias - deletes all branches that have been merged into master (I think)
alias gitbd='git branch --merged | grep -i -v -E "master"| xargs git branch -d'
# seems to do the same thing as above, but also removes remote, actually no seems to be better version of above command
alias gitprune="git remote prune origin && git branch --merged origin/master | xargs git branch -d"

alias git_rm_untracked="git ls-files --others --exclude-standard | xargs rm -rfv"



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
alias gtcops="cd ~/Code/devops/gtc/"
alias gtcrust="cd ~/Code/rust/gattaca"
alias paladin="cd ~/Code/go/src/github.com/PaladinNetwork"
alias gtcdocs="gtcgo && cd GattacaDocs && vim ."

function init_testnet() {
    gtcgo
    cd gtc-avalanche-network-runner
    rm -rf ~/.avalanchego && AVAXBUILDPATH=$GOPATH/src/github.com/ava-labs/avalanchego/build/avalanchego ./scripts/run.sh
}


function program_exists() {
    # TODO figure out why this and not `which`
    hash $1 2>/dev/null
}


# Set up neovim
# alias nvim="~/bin/nvim.appimage"
if program_exists lvim; then
    alias vim=lvim
fi

# My todos for the day
export TODO_DIR=~/Documents/todos
function todo()  { vim $TODO_DIR/the-big-todo.md }
alias todo_rice="vim $TODO_DIR/ricing-todo.md"
alias todo_productivity="vim $TODO_DIR/producivity-todo.md"
# TODO need to put this into an if
#
if program_exists clipboard ; then
    alias clipboard=clipboard
    # If system is wayland
elif [[ $XDG_SESSION_TYPE = 'wayland' ]]; then
    alias clipboard=wl-copy
else
    alias clipboard="xclip -sel clip"
fi

# helpful methods
is_running() { ps aux | grep $1 }
untar() { tar -xzvf $1 }
reset_keyboard() { sh ~/.profile }

swap_caps_esc_alt_win() {
    local layout=${1:-gb} # Default to 'gb' if no argument is provided

    # Clear the existing layout
    setxkbmap -layout $layout -option
    # make CapsLock behave like Ctrl:
    setxkbmap -layout $layout -option ctrl:nocaps -option altwin:swap_alt_win

    # make short-pressed Ctrl behave like Escape:
    xcape -e 'Control_L=Escape'
}

# todo need to figure out how to name this, doesn't include swap_alt_win
swap_caps_esc() {
    local layout=${1:-gb} # Default to 'gb' if no argument is provided

    setxkbmap -layout $layout -option # make CapsLock behave like Ctrl:
    setxkbmap -layout $layout -option ctrl:nocaps #option altwin:swap_alt_win

    # make short-pressed Ctrl behave like Escape:
    xcape -e 'Control_L=Escape'
}

# Way of searching through howdoi in terminal
function hdi(){ howdoi $* -c -n 5; }

# Sets the brightness for all connected monitors through xrandr
brightness() {
    xrandr | grep -E "\sconnected" | awk '{print $1}' | xargs -I {} xrandr --output {} --brightness $1
}


pick_timezone() {
    timedatectl set-timezone $(timedatectl list-timezones | fzf)
}

pid_from_ps_aux() {
    awk '{print $2}'
}

kill_processes() {
    if [ -z "$1" ]; then
        echo "No kill mode selected, using default of -9"
        kill_mode="-9"
    else
        kill_mode="$1"
    fi
    ps aux | fzf -m | pid_from_ps_aux | xargs kill $kill_mode
}


color_picker() {
    color=$(grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n 1 | awk '{print $3}')
    echo $color
    echo $color | clipboard
}


##########################################################################################
##########################  Shell script utililties  #####################################
##########################################################################################


convert_image() {
    ffmpeg -i $1 -preset ultrafast $2
}


###########################################################################################
#######################        Language Specfics       ####################################
###########################################################################################

## Node stuff

install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
}

# too add node version manager support
# This loads nvm
export NVM_DIR="/home/layz/.nvm"
if [ -f $NVM_DIR/nvm.sh ]; then
    . "$NVM_DIR/nvm.sh"
else
    # TODO ask if we want to install nvm?
    install_nvm
fi

# Turn zsh into vim mode
# bindkey -v


# Go stuff!
# only do this if the go binary is available
if program_exists go ; then
    export GOBIN=$HOME/Code/go/bin
    export GOPATH=$HOME/Code/go
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
        }'      > main.go
        vim main.go
    }
fi



# Rust stuff

rust_clear_target(){
    find . -name target -type d | xargs rm -rfv
}


# Ruby stuff

# https://rvm.io/rvm/install
install_rvm() {
    gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable --ruby
}

if [ -f ~/.rvm/scripts/rvm ]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    source ~/.rvm/scripts/rvm
    export PATH="$PATH:$HOME/.rvm/bin"
else
    # TODO ask if we want to install rvm?
    install_rvm
    source ~/.rvm/scripts/rvm
fi


##############################################################################
##################### fun shell methods chatGPT ##############################
##############################################################################

# Method generated by chatGPT for me to be able to automatically download and cd to exericism exercises!
# https://chat.openai.com/share/c2335b92-cdb1-4d21-9e61-b2e030ecf281
# TODO maybe turn this into a cli tool :joy:
function exsm() {
    case "$1" in
        init)
            if [ "$#" -lt 2 ]; then
                echo "An additional argument needs to be provided for init."
                return 1
            fi

            # Remove 'init' from the argument list
            shift

            # The rest of the code is for the 'init' functionality
            command_output=$($@ 2>&1)
            command_status=$?

            # Check if the command was successful
            if [ $command_status -ne 0 ]; then
                echo "An error occurred while running the command."
                echo "$command_output"
                return $command_status
            fi

            # Extract the directory from the output
            # Assuming the directory is on the next line after "Downloaded to"
            directory=$(echo "$command_output" | awk '/Downloaded to/{getline; print}' | xargs)

            # Check if the directory is not empty and exists
            if [[ -z "$directory" ]] || [[ ! -d "$directory" ]]; then
                echo "The output directory could not be determined from the command output."
                return 1
            fi

            # Change directory to the extracted path
            cd "$directory" || {
                echo "Failed to change directory to $directory."
                return 1
            }
            nvim .
            ;;

        push)
            exercism submit $(find . -type f -not -name "*test*" -name "*.rb") && exercism open .
            # You would implement whatever you need for the 'push' command here.
            ;;

        *)
            echo "Usage: exercism_tool {init|push} [...]"
            return 1
            ;;
    esac
}

########################## Place to keep fun and technological information #################
fun_n_technological(){
    vim ~/Documents/EarthAcre/fun_n_technological.md
}




##########################################################################################

## Try to get correct editor for visual?
export VISUAL="vim"

# IP stuff?
# Automatically gets your public ip address and copies it into the clipboard for use
whatsmyip() {
    ## dig +short myip.opendns.com resolver2.opendns.com | clipboard
    curl https://ipinfo.io/ip | clipboard
}

# Scan local network for Machines and some info about them
nmap_scan_local() {
    sudo nmap -sn 192.168.1.0/24
}

backspace_swapped() {
    echo -e "keycode 22 = slash\n keycode 61 = BackSpace question" | xmodmap -
}

backspace_normal() {
    echo -e "keycode 61  = slash question \n keycode 22 = BackSpace" | xmodmap -
}


alias sshconfig="vim ~/.ssh/config"



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

# Used for poetry autoloading completion
fpath+=~/.zfunc
autoload -Uz compinit && compinit

## Conda
alias condasetup="source ~/anaconda3/bin/activate"


# PYenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init -)"


# Flatpak installation
PATH=/var/lib/flatpak/app:$PATH

export PATH="$PATH:/home/layz/.foundry/bin"


# Set up chrome apps
export PATH="$PATH:$DOTFILES_DIR/chrome-apps"


# TMUX specific stuff
reload_tmux_conf() {
    tmux source-file ~/.tmux.conf
}

if [ -f /tmp/foo.txt ]; then
    xrdb ~/.Xresources
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#B08AE7,bg=underline

# thanks to vi-mode plugin, need to run these key binds after zsh init
function zvm_after_init() {
    # Initialize fzf
    if [ -f ~/.fzf.zsh ]; then
        source ~/.fzf.zsh
        # now lets do some zsh specific functions

        # TODO try to figure out a way to produce some kind of usability like
        # https://github.com/ajeetdsouza/zoxide but with zsh
        #function zcd() {
        #    dir=[ -z "$1"] || cwd
        #    while [ -d $dir ]" do
        #        dir=$(ls $dir | fzf)
        #        echo $dir
        #    done
        #}
        FZF_DEFAULT_COMMAND="fd . $HOME"
        FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        FZF_ALT_C_COMMAND="fd -i -t d -L --exclude 'go/pkg' --exclude 'node_modules' -d 6 . $HOME"
    fi
    #

    # allow for ctrl space to accept auto suggestion
    bindkey '^ ' autosuggest-accept

}




source $ZSH/oh-my-zsh.sh


# Notifier for long running bash operaitons
[[ -f /usr/share/undistract-me/undistract-me.sh ]] && source /usr/share/undistract-me/undistract-me.sh

# New files to replace common cli utilities
unalias ls
alias ls=exa
alias la="ls -la"
alias ll="ls -la"


# TRAPWINCH() {
#   zle && { zle reset-prompt" zle -R }
# }

# Start TMUX off
# If not running interactively, do not do anything
#[[ $- != *i* ]] && return
# Otherwise start tmux
#[[ -z "$TMUX" ]] && exec tmux new-session -A -s main && exit
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(atuin init zsh)"
CLUSTER=arn:aws:ecs:us-east-1:853100499654:cluster/tradable-non-production-ecs
SERVICE=arn:aws:ecs:us-east-1:853100499654:service/tradable-non-production-ecs/tradable-non-production-onchain-service
