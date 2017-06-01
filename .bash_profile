export ANDROID_HOME=/usr/local/opt/android-sdk
export JAVA_HOME=$(/usr/libexec/java_home)
export GOPATH=$HOME/Development/go

# Workaround for Apple having removed the OpenSSL headers on El Capitan
export OPENSSL_ROOT_DIR=/usr/local/Cellar/openssl/1.0.2d_1

export PATH="/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH"

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

# Enable GPG agent
if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
  GPG_TTY=$(tty)
  export GPG_TTY
else
  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

source /usr/local/etc/bash_completion.d/git-prompt.sh

# Use PROMPT_COMMAND for a faster PS1 with __git_ps1
if [[ `type -t update_terminal_cwd` == 'function' ]]; then
  OSX_FUNCTION=update_terminal_cwd
fi

PROMPT="\[\033[1;33m\]\u@\h\[\033[0m\]:\w"
export PROMPT_COMMAND='$OSX_FUNCTION; __git_ps1 "$PROMPT" "$([[ -z $GS_NAME ]] || echo -e " \[\033[0;35m\]{$GS_NAME}\[\033[0m\]")\n\$ "'


# Auto complete
complete -C aws_completer aws

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#Aliases

alias gist='gist -c'
alias grep='grep --color=auto'
alias dm='docker-machine'
alias fetchrebase='git fetch --prune && git rebase origin/master'

# Load private configuration
source ~/.bash_profile_private

