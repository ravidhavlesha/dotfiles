export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

HISTFILE=~/.zsh_history

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin

eval $(keychain --eval --quiet --agents ssh id_rsa_1 id_rsa_2)

# Aliases
alias zshconfig="vi ~/.zshrc"
alias clear="clear && history -c && clear"
alias update="sudo apt update && sudo apt upgrade && sudo apt autoremove -y && sudo apt-get autoclean"
alias d="docker"
alias dc="docker compose"
