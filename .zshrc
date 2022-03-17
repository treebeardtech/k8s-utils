
   
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh

alias k=kubectl
alias h=history
alias wh=which

export EDITOR=vi
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh