export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export ANDROID_HOME=/usr/local/opt/android-sdk
export JAVA_HOME=$(/usr/libexec/java_home)

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=/usr/bin/vim

# Ignore from history repeat commands, and some other unimportant ones
export HISTIGNORE="&:[bf]g:c:exit"
export HISTCONTROL="ignoreboth"

# Add some colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# PS1
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

source /usr/local/etc/bash_completion.d/git-prompt.sh

# __git_ps1 will set $PS1
export PROMPT="\[\033[1;33m\]\u@\h:\[\033[0m\]\W"
export PROMPT_COMMAND='__git_ps1 $PROMPT "\\\$ "'

# Auto complete
complete -C aws_completer aws

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#Aliases

alias gist='gist -c'
alias redis-cli='redis-cli -p 11001'
alias grep='grep --color=auto'

