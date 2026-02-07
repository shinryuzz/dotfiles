# #########################################################
# Global Settings
# #########################################################
unsetopt GLOBAL_RCS
export LANG=ja_JP.UTF-8

# #########################################################
# XDG Base Directory
# #########################################################
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"

# #########################################################
# Zsh
# #########################################################
export ZSH="$XDG_DATA_HOME"/oh-my-zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# #########################################################
# Go
# #########################################################
export GOPATH="$XDG_DATA_HOME/go"

# #########################################################
# Rust
# #########################################################
export RUST_BACKTRACE=1
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
