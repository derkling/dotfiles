LOGFILE=/tmp/dotfiles.log

default: all
help:
	@echo 'Management commands for dotfiles:'
	@echo
	@echo 'Usage:'
	@echo '    make install-deps       Install system dependencies.'
	@echo '    make clean-nvim         Purge Neovim data/state/cache.'
	@echo
	@echo '    make all                Run all.'
	@echo
	@echo '    Logs are stored in      $(LOGFILE)'
	@echo
	@echo '    Author                  Patric Bellasi (github.com/derkling)'
	@echo '    Based on work from      Ben Mezger (github.com/benmezger)'

install-deps:
	@echo "Installing dependencies.."
	bash ./scripts/install_deps.sh | tee -a $(LOGFILE) || exit 1

clean-nvim:
	@echo "Cleaning Neovim data/state/cache.."
	rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

all:
	$(MAKE) install-deps
