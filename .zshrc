export GOPATH=$HOME/Development/go

# Workaround for Apple having removed the OpenSSL headers on El Capitan
export OPENSSL_ROOT_DIR=/usr/local/Cellar/openssl/1.0.2d_1

# export PATH="/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:/usr/local/lib/ruby/gems/2.6.0/bin:$GOPATH/bin:$PATH"

# export LDFLAGS="-L/usr/local/opt/ruby/lib"
# export CPPFLAGS="-I/usr/local/opt/ruby/include"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=/usr/local/bin/vim

# Add some colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# PS1
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

# source /usr/local/etc/bash_completion.d/git-prompt.sh

# Use PROMPT_COMMAND for a faster PS1 with __git_ps1
# if [[ `type -t update_terminal_cwd` == 'function' ]]; then
#  OSX_FUNCTION=update_terminal_cwd
# fi

# PROMPT="\[\033[1;33m\]\u@\h\[\033[0m\]:\w"
# export PROMPT_COMMAND='$OSX_FUNCTION; __git_ps1 "$PROMPT" "$([[ -z $GS_NAME ]] || echo -e " \[\033[0;35m\]{$GS_NAME}\[\033[0m\]")\n\$ "'


# Auto complete
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit
compinit
# complete -C aws_completer aws

#Aliases

alias gist='gist -c'
alias grep='grep --color=auto'
alias dm='docker-machine'
alias fetchrebase='git fetch --prune && git rebase origin/master'