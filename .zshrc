# Fire into tmux by default
if command -v tmux &> /dev/null && [ -z "$TMUX"  ]; then
	[ "$(tmux attach -t default || tmux new -s default)" = "[exited]" ] && exit
fi
#
# Zsh terminal options
setopt +o nomatch
setopt INC_APPEND_HISTORY

export TIGH_CONFIG=${HOME}/.config/tigh-latte

[ -f ${TIGH_CONFIG}/environment ] && source ${TIGH_CONFIG}/environment

# Completion
autoload -U compinit && compinit
source <(docker completion zsh)
source <(kubectl completion zsh)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Smart case matching
zstyle ':completion:*'  menu select # present options as a menu
zstyle ':completion:*'  completer _complete _approximate # allow a bit of tolerance

bindkey -e # disable vim input mode

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\e[A' history-beginning-search-backward-end
bindkey '\e[B' history-beginning-search-forward-end

# Word jumping
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Edit the current command in $EDITOR
autoload edit-command-line && zle -N edit-command-line
bindkey "^X^E" edit-command-line # bash-style binding

eval "$(starship init zsh)"
