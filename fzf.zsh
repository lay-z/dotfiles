# Setup fzf
# ---------
if [[ ! "$PATH" == */home/layz/Code/dotfiles/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/layz/Code/dotfiles/fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/layz/Code/dotfiles/fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/layz/Code/dotfiles/fzf/shell/key-bindings.zsh"
