# Fire into tmux by default
if command -v tmux &> /dev/null && [ -z "$TMUX"  ]; then
	tmux attach -t default || tmux new -s default && exit
fi
########################## ZSH Shell Default Stuff #####################################

export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="tigh"

plugins=(git docker docker-compose golang kubectl minikube tmux)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

########################## My Own Stuff ################################################

# Zsh terminal options
setopt +o nomatch
setopt INC_APPEND_HISTORY

[ -f ${HOME}/.environment ] && source ${HOME}/.environment
