if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -lah --git --group-directories-first --icons=auto'
else
  alias ls='ls -G'
  alias ll='ls -lahG'
fi

alias grep='grep --color=auto'
alias gist='gist -c'
alias fetchrebase='git fetch --prune && git rebase origin/$(git branch --show-current)'
