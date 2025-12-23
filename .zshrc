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

bindkey -e # disable vim input mode

# Completion
autoload -Uz compinit && compinit
source <(docker completion zsh)
source <(kubectl completion zsh)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Smart case matching
zstyle ':completion:*' menu select # present options as a menu
zstyle ':completion:*' completer _complete _approximate # allow a bit of tolerance

eval "$(dircolors -b ${TIGH_CONFIG}/dircolours)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Up/Down searches history prefixed with current input
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\e[A' history-beginning-search-backward-end
bindkey '\e[B' history-beginning-search-forward-end

# word recognition
WORDCHARS="$WORDCHARS :"
WORDCHARS="*?-.[]~=/&;!#$%^(){}<> :"
autoload -Uz select-word-style
select-word-style normal
zstyle ':zle:*' word-style specified

# word jumping
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# word deletion
bindkey '^H' backward-kill-word
bindkey '^[[3~' delete-char
bindkey '^[[3;5~' kill-word

# Edit the current command in $EDITOR
autoload edit-command-line && zle -N edit-command-line
bindkey "^X^E" edit-command-line # bash-style binding

eval "$(starship init zsh)"
