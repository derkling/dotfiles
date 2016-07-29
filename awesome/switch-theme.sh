#! /usr/bin/make -f

# Inspired by Awesome Copycats switch theme script:
#   https://github.com/copycat-killer/awesome-copycats

AWESOME_DIR=~/dotfiles/awesome

# $(swap_dialog)
define swap_dialog
	echo ; \
	echo "Available themes:" ; \
	echo ; $(THEMES) | cat -n ; echo ; \
	read -p "Switch to theme: " NUM ; \
	if [ ! -z $NUM -a $NUM -ge 1 -a -le $N_THEMES ] ; then \
	  NEW_THEME=$(${THEMES} | head -n${num} | tail -n1 ) ; \
	  rm theme; \
	  ln -s $(AWESOME_DIR)/themes/${NEW_THEME} theme; \
	  echo "Theme is now ${NEW_THEME}"; \
  else echo " !! Aborted. " ; fi
endef

# $(themes)
THEMES=ls $(AWESOME_DIR)/themes

# number of current themes
N_THEMES=$(THEMES) | wc -l

.SILENT : all

all:
	cd $(AWESOME_DIR) && \
	$(swap_dialog)
