# ZSH
ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# HISTORY
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# PLUGINS
plugins=(git)

source $ZSH/oh-my-zsh.sh
eval "$(oh-my-posh init zsh --config ~/.oh-my-zsh/custom/themes/custom.json)"
