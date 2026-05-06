export LANG="en_US.UTF-8"
export EDITOR="${EDITOR:-vim}"
export VISUAL="$EDITOR"
export PAGER="${PAGER:-less}"

# Keep PATH/fpath deduplicated as we prepend toolchains below.
typeset -U path fpath

# Personal binaries first.
path=(
  "$HOME/.local/bin"
  $path
)

# Shell behavior: history, navigation, and interactive quality-of-life.
setopt auto_cd
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt interactive_comments
setopt prompt_subst
setopt share_history

# Keep path segments as separate words for Option+Arrow navigation.
WORDCHARS="${WORDCHARS//\/}"
WORDCHARS="${WORDCHARS//-}"

mkdir -p "$HOME/.local/state/zsh"
export HISTFILE="$HOME/.local/state/zsh/history"
export HISTSIZE=50000
export SAVEHIST=50000

# Completion and prompt helpers.
autoload -Uz compinit colors vcs_info
zmodload zsh/complist
colors

if [[ -d "$HOME/.local/share/zsh/site-functions" ]]; then
  fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
fi

mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/.zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{244}on %F{81}%b%f'
zstyle ':vcs_info:git:*' actionformats ' %F{244}on %F{81}%b|%a%f'

# Refresh Git branch info before each prompt render.
precmd() {
  vcs_info
}

# Two-line prompt: context on top, prompt symbol on the bottom.
PROMPT=$'%F{81}%n%f %F{244}in%f %F{228}%~%f${vcs_info_msg_0_}\n%(?.%F{42}.%F{196})❯%f '
RPROMPT='%F{240}%*%f'

# Prefer modern replacements.
alias ls='eza --group-directories-first --icons=auto'
alias ll='eza -lah --git --group-directories-first --icons=auto'

alias grep='grep --color=auto'
alias fetchrebase='git fetch --prune && git rebase origin/$(git branch --show-current)'

# Linux shell niceties.
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

# Manage tool versions with mise.
eval "$(mise activate zsh)"

# Jump to frequent directories.
eval "$(zoxide init zsh)"

# zsh-autosuggestions partially accepts suggestions when forward-word runs.
bindkey '^[f' forward-word
bindkey '^[[1;3C' forward-word
bindkey '^[b' backward-word
bindkey '^[[1;3D' backward-word
