# Setup fzf
# ---------
if [[ ! "$PATH" == */home/layz/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/layz/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/layz/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/layz/.fzf/shell/key-bindings.zsh"
