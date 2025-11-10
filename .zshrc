# Path
export PATH="/usr/local/bin:$PATH"

. "$HOME/.local/bin/env"

# Prompt
eval "$(starship init zsh)"

# Nodejs
eval "$(fnm env --use-on-cd)"

# Plugins
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Aliases
# ------------------------------
# 📁 Navigation
# ------------------------------

alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ------------------------------
# 📂 Files & Listing
# ------------------------------

alias ll="ls -la"              # detailed list
alias la="ls -A"               # all except . and ..
alias l="ls -CF"               # short list with types

# ------------------------------
# 🔧 Git Shortcuts
# ------------------------------

alias gst="git status -s"
alias gaa="git add ."
alias gps="git push"
alias gpl="git pull"
alias gcm="git commit -m"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias grh="git reset --hard"
alias gundo="git reset --soft HEAD~1"
alias glog="git log --oneline --graph --decorate --all"

# ------------------------------
# ⚙️ Misc Utilities
# ------------------------------

alias reload="source ~/.zshrc"
alias path="echo $PATH | tr ':' '\n'"
alias ports="lsof -i -P -n | grep LISTEN"   # all open network ports system is listening
alias ip="curl ifconfig.me"                 # public ip address
alias clearhist="rm -f ~/.zsh_history"
alias c="clear"

# pnpm
export PNPM_HOME="/Users/ravidhavlesha/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
