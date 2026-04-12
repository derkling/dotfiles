LOGFILE=/tmp/dotfiles.log

default: all
help:
	@echo 'Management commands for dotfiles:'
	@echo
	@echo 'Usage:'
	@echo '    make bootstrap          Provision host and default toolbox.'
	@echo '    make install-deps       Install system dependencies.'
	@echo '    make clean-nvim         Purge Neovim data/state/cache.'

	@echo
	@echo '    make all                Run all.'

	@echo
	@echo '    Logs are stored in      $(LOGFILE)'

	@echo
	@echo '    Author                  Patric Bellasi (github.com/derkling)'
	@echo '    Based on work from      Ben Mezger (github.com/benmezger)'

	bootstrap:
		@echo "Bootstrapping system..."
		@if [ -f /run/host/etc/os-release ] && grep -q "VARIANT_ID=.*-atomic" /run/host/etc/os-release; then \
			bash ~/.local/bin/bootstrap-system; \
		elif [ -f /etc/os-release ] && grep -E -q "ID=(debian|ubuntu)" /etc/os-release; then \
			$(MAKE) install-deps; \
		else \
			echo "Unsupported system for automated bootstrap."; \
			exit 1; \
		fi | tee -a $(LOGFILE) || exit 1

	install-deps:
	@echo "Installing dependencies.."
	bash ./scripts/install_deps.sh | tee -a $(LOGFILE) || exit 1

clean-nvim:
	@echo "Cleaning Neovim data/state/cache.."
	rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

all:
	$(MAKE) install-deps
