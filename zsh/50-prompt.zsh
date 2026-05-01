autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{245}on %F{111}%b%f'
zstyle ':vcs_info:git:*' actionformats ' %F{245}on %F{111}%b|%a%f'

precmd_update_vcs() {
  vcs_info
}

add-zsh-hook precmd precmd_update_vcs

PROMPT=$'%F{81}%n%f %F{244}in%f %F{228}%~%f${vcs_info_msg_0_}\n%(?.%F{42}.%F{196})❯%f '
RPROMPT='%F{240}%*%f'
