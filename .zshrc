export LANG="en_US.UTF-8"

typeset -U path fpath

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export DOTFILES_ROOT="${${(%):-%N}:A:h}"
export EDITOR="${EDITOR:-vim}"
export VISUAL="$EDITOR"
export PAGER="${PAGER:-less}"

path=(
  "$HOME/.local/bin"
  "$HOME/.pub-cache/bin"
  "$HOME/Development/flutter/bin"
  $path
)

for config_file in "$DOTFILES_ROOT"/zsh/*.zsh(N); do
  source "$config_file"
done
