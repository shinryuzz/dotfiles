.PHONY: help init init-force install-deps lint update clean

SHELL := /bin/bash

# #########################################################
# Help
# #########################################################
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

# #########################################################
# Setup
# #########################################################
init: ## Create symlinks
	@./setup.sh

init-force: ## Create symlinks (overwrite existing)
	@./setup.sh --force

install-deps: ## Install dependencies (Homebrew, Oh-My-Zsh, etc.)
	@./scripts/install-deps.sh

# #########################################################
# Lint
# #########################################################
lint: ## Run shellcheck on shell scripts
	@shellcheck setup.sh scripts/*.sh

# #########################################################
# Update
# #########################################################
update: update-brew update-omz update-tpm ## Update all

update-brew: ## Update Homebrew packages
	@echo "Updating Homebrew..."
	@brew update && brew upgrade

update-omz: ## Update Oh-My-Zsh
	@echo "Updating Oh-My-Zsh..."
	@"$${ZSH:-$$HOME/.local/share/oh-my-zsh}/tools/upgrade.sh"

update-tpm: ## Update tmux plugins
	@echo "Updating tmux plugins..."
	@"$${XDG_DATA_HOME:-$$HOME/.local/share}/tmux/plugins/tpm/bin/update_plugins" all

# #########################################################
# Clean
# #########################################################
clean: ## Remove symlinks
	@echo "Removing symlinks..."
	@rm -f ~/.config/zsh ~/.config/alacritty ~/.config/nvim ~/.config/tmux ~/.hammerspoon
	@echo "Done."
