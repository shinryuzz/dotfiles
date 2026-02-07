#!/bin/bash
#
# dotfiles setup script
# Usage: ./setup.sh [OPTIONS]
#
# Options:
#   -f, --force    Overwrite existing symlinks
#   -h, --help     Show this help message
#

set -eu

# #########################################################
# Constants
# #########################################################
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly SCRIPT_DIR
readonly CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m' # No Color

# #########################################################
# Utility Functions
# #########################################################
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

usage() {
    head -n 10 "$0" | tail -n 8 | sed 's/^# //' | sed 's/^#//'
    exit 0
}

# #########################################################
# Parse Arguments
# #########################################################
FORCE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            error "Unknown option: $1"
            usage
            ;;
    esac
done

# #########################################################
# Symlink Functions
# #########################################################
create_symlink() {
    local src="$1"
    local dst="$2"

    if [[ -L "$dst" ]]; then
        if [[ "$FORCE" == true ]]; then
            rm "$dst"
            ln -s "$src" "$dst"
            info "Replaced symlink: $dst -> $src"
        else
            warn "$dst already exists (symlink), skipping... (use -f to overwrite)"
        fi
    elif [[ -e "$dst" ]]; then
        warn "$dst already exists (file/directory), skipping..."
    else
        mkdir -p "$(dirname "$dst")"
        ln -s "$src" "$dst"
        info "Created symlink: $dst -> $src"
    fi
}

# #########################################################
# Main Setup
# #########################################################
main() {
    info "Starting dotfiles setup..."
    info "Script directory: $SCRIPT_DIR"
    info "Config home: $CONFIG_HOME"

    # XDG config directories
    local -a xdg_dirs=(
        "zsh"
        "alacritty"
        "nvim"
        "tmux"
    )

    for dir in "${xdg_dirs[@]}"; do
        create_symlink "$SCRIPT_DIR/$dir" "$CONFIG_HOME/$dir"
    done

    # Hammerspoon (uses ~/.hammerspoon)
    create_symlink "$SCRIPT_DIR/hammerspoon" "$HOME/.hammerspoon"

    info "Setup completed!"
}

main "$@"
