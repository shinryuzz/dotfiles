#!/bin/bash
#
# Install dependencies for dotfiles
# Usage: ./scripts/install-deps.sh
#

set -eu

readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# #########################################################
# OS Detection
# #########################################################
detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)  echo "linux" ;;
        *)      echo "unknown" ;;
    esac
}

# #########################################################
# Homebrew (macOS)
# #########################################################
install_homebrew() {
    if command -v brew &>/dev/null; then
        info "Homebrew already installed"
        return
    fi

    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_brew_packages() {
    info "Installing Homebrew packages..."

    local -a packages=(
        # Shell
        "zsh"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "zsh-abbr"
        "autojump"

        # Terminal
        "tmux"
        "alacritty"

        # Tools
        "fzf"
        "ghq"
        "mise"
        "neovim"

        # Development
        "git"
        "gh"
        "shellcheck"
    )

    for pkg in "${packages[@]}"; do
        if brew list "$pkg" &>/dev/null; then
            info "$pkg already installed"
        else
            info "Installing $pkg..."
            arch -arm64 brew  install "$pkg"
        fi
    done
}

# #########################################################
# Oh-My-Zsh
# #########################################################
install_oh_my_zsh() {
    local omz_dir="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"

    if [[ -d "$omz_dir" ]]; then
        info "Oh-My-Zsh already installed"
        return
    fi

    info "Installing Oh-My-Zsh..."
    ZSH="$omz_dir" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# #########################################################
# Powerlevel10k
# #########################################################
install_powerlevel10k() {
    local omz_dir="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"
    local p10k_dir="$omz_dir/custom/themes/powerlevel10k"

    if [[ -d "$p10k_dir" ]]; then
        info "Powerlevel10k already installed"
        return
    fi

    info "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
}

# #########################################################
# TPM (Tmux Plugin Manager)
# #########################################################
install_tpm() {
    local tpm_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/plugins/tpm"

    if [[ -d "$tpm_dir" ]]; then
        info "TPM already installed"
        return
    fi

    info "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

# #########################################################
# Main
# #########################################################
main() {
    local os
    os="$(detect_os)"

    info "Detected OS: $os"

    case "$os" in
        macos)
            install_homebrew
            install_brew_packages
            ;;
        linux)
            warn "Linux package installation not implemented yet"
            warn "Please install packages manually: zsh, tmux, fzf, ghq, neovim"
            ;;
        *)
            error "Unsupported OS"
            exit 1
            ;;
    esac

    install_oh_my_zsh
    install_powerlevel10k
    install_tpm

    info "Dependencies installation completed!"
    info "Run 'make init' to create symlinks"
}

main "$@"
