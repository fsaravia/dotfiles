# Locale
export LANG=en_US.UTF-8

# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Completions
autoload -Uz compinit
compinit

# Colors
autoload -Uz colors && colors
PROMPT="%{$fg[green]%}%n@%m %{$fg[blue]%}%~%{$reset_color%} ➤ "

#Aliases
alias gist='gist -c'
alias grep='grep --color=auto'
alias ls='ls -G'
alias fetchrebase='git fetch --prune && git rebase origin/main'

# Load Flutter
export PATH=$HOME/Development/flutter/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

