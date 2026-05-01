export LANG="en_US.UTF-8"
export EDITOR="${EDITOR:-vim}"
export VISUAL="$EDITOR"
export PAGER="${PAGER:-less}"

typeset -U path fpath

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

path=(
  "$HOME/.local/bin"
  "$HOME/.pub-cache/bin"
  $path
)

if [[ -d "$HOME/Development/flutter/bin" ]]; then
  path=("$HOME/Development/flutter/bin" $path)
fi

setopt auto_cd
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt interactive_comments
setopt prompt_subst
setopt share_history

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

autoload -Uz compinit colors vcs_info
zmodload zsh/complist
colors

mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/.zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{244}on %F{81}%b%f'
zstyle ':vcs_info:git:*' actionformats ' %F{244}on %F{81}%b|%a%f'

precmd() {
  vcs_info
}

PROMPT=$'%F{81}%n%f %F{244}in%f %F{228}%~%f${vcs_info_msg_0_}\n%(?.%F{42}.%F{196})❯%f '
RPROMPT='%F{240}%*%f'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -lah --git --group-directories-first --icons=auto'
else
  alias ls='ls -G'
  alias ll='ls -lahG'
fi

alias grep='grep --color=auto'
alias fetchrebase='git fetch --prune && git rebase origin/$(git branch --show-current)'

if command -v brew >/dev/null 2>&1; then
  HOMEBREW_PREFIX="$(brew --prefix)"

  [[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
  [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi
