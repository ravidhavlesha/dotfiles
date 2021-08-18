PROMPT_EOL_MARK=''

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Aliases
alias zshconfig="vi ~/.zshrc"
alias clearhistory="clear && rm -rf ~/.zsh_history && touch ~/.zsh_history"
alias update="sudo apt update && sudo apt upgrade && sudo apt clean && sudo apt autoremove"
alias d="docker"
alias dc="docker-compose"
alias dcdv="dc down && d volume prune"
alias restartui="dc down && dc up"
alias cleanui="sudo rm -rf node_modules containers/backend/node_modules containers/frontend/node_modules && npm run initialize"
alias awslogin="sh /home/ravi/custom_scripts/aws_cli.sh $1"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin:/home/ravi/go/bin/
