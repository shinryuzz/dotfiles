# #########################################################
# Path
# #########################################################
typeset -gU PATH path

path=(
  '/opt/homebrew/bin'(N-/)
  '/opt/homebrew/sbin'(N-/)
  '/usr/local/bin'(N-/)
  '/usr/local/sbin'(N-/)
  '/bin'(N-/)
  '/usr/bin'(N-/)
)

path=(
  "$HOME/.local/bin"(N-/)
  "$CARGO_HOME/bin"(N-/)
  "$GOPATH/bin"(N-/)
  "$VOLTA_HOME/bin"(N-/)
  "$path[@]"
)

# #########################################################
# Powerlevel10k
# #########################################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ${ZDOTDIR:-~}/.p10k.zsh ]] || source ${ZDOTDIR:-~}/.p10k.zsh

# #########################################################
# Oh-My-Zsh
# #########################################################
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
)

[[ -s /Users/shinryuzz/.autojump/etc/profile.d/autojump.sh ]] && source /Users/shinryuzz/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

source $ZSH/oh-my-zsh.sh

# #########################################################
# History
# #########################################################
HISTFILE="$XDG_STATE_HOME/zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

# #########################################################
# Aliases
# #########################################################
source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias gcc="gcc-14"
alias brew="arch -arm64 brew"

abbr -S --quieter tf="terraform"
abbr -S --quieter lz="lazygit"
abbr -S --quieter dc="docker compose"

# #########################################################
# Functions
# #########################################################

# fzf + history
function fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --height 75% --no-sort +m --query "$LBUFFER" --prompt="History >")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# fzf + ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --height 75% --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

# #########################################################
# Integrations
# #########################################################

# Google Cloud SDK
if [ -f '/Users/shinryuzz/Downloads/google-cloud-sdk/path.zsh.inc' ]; then
  source '/Users/shinryuzz/Downloads/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/shinryuzz/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then
  source '/Users/shinryuzz/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

# mise
eval "$(mise activate zsh)"
