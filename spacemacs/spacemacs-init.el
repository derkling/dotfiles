
;; [[file:~/.spacemacs.d/spacemacs.org::*Initialization][Initialization:1]]

(setq-default
 dotspacemacs-enable-emacs-pdumper nil
 dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"
 dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"
 dotspacemacs-elpa-https t
 dotspacemacs-elpa-timeout 5
 dotspacemacs-gc-cons '(100000000 0.1)
 dotspacemacs-use-spacelpa nil
 dotspacemacs-verify-spacelpa-archives nil
 dotspacemacs-check-for-update t
 dotspacemacs-elpa-subdirectory 'emacs-version
 dotspacemacs-editing-style 'vim
 dotspacemacs-verbose-loading nil
 dotspacemacs-startup-banner nil
 dotspacemacs-startup-lists '((recents . 5)
                              (bookmarks . 5)
                              (projects . 7))
 dotspacemacs-startup-buffer-responsive t
 dotspacemacs-scratch-mode 'text-mode
 dotspacemacs-initial-scratch-message nil
 dotspacemacs-themes '(spacemacs-dark
                       spacemacs-light)
 dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)
 dotspacemacs-colorize-cursor-according-to-state t
 dotspacemacs-default-font '("Ubuntu Mono"
                             :size 14 :weight normal :width normal)
 dotspacemacs-leader-key "SPC"
 dotspacemacs-emacs-command-key "SPC"
 dotspacemacs-ex-command-key ":"
 dotspacemacs-emacs-leader-key "M-m"
 dotspacemacs-major-mode-leader-key ","
 dotspacemacs-major-mode-emacs-leader-key "C-M-m"
 dotspacemacs-distinguish-gui-tab nil
 dotspacemacs-default-layout-name "Default"
 dotspacemacs-display-default-layout 't
 dotspacemacs-auto-resume-layouts nil
 dotspacemacs-auto-generate-layout-names nil
 dotspacemacs-large-file-size 1
 dotspacemacs-auto-save-file-location 'cache
 dotspacemacs-max-rollback-slots 5
 dotspacemacs-enable-paste-transient-state nil
 dotspacemacs-which-key-delay 0.2
 dotspacemacs-which-key-position 'bottom
 dotspacemacs-switch-to-buffer-prefers-purpose nil
 dotspacemacs-loading-progress-bar nil
 dotspacemacs-fullscreen-at-startup nil
 dotspacemacs-fullscreen-use-non-native nil
 dotspacemacs-maximized-at-startup nil
 dotspacemacs-active-transparency 90
 dotspacemacs-inactive-transparency 90
 dotspacemacs-show-transient-state-title t
 dotspacemacs-show-transient-state-color-guide t
 dotspacemacs-mode-line-unicode-symbols nil
 dotspacemacs-smooth-scrolling t
 dotspacemacs-line-numbers '(:relative t
                          :disabled-for-modes dired-mode pdf-view-mode
                             :size-limit-kb 1000)
 dotspacemacs-folding-method 'evil
 dotspacemacs-smartparens-strict-mode nil
 dotspacemacs-smart-closing-parenthesis nil
 dotspacemacs-highlight-delimiters 'all
 dotspacemacs-enable-server nil
 dotspacemacs-server-socket-dir nil
 dotspacemacs-persistent-server nil
 dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
 dotspacemacs-frame-title-format "%I@%S"
 dotspacemacs-icon-title-format nil
 dotspacemacs-whitespace-cleanup "trailing"
 dotspacemacs-zone-out-when-idle nil
 dotspacemacs-pretty-docs nil
 )

;; Initialization:1 ends here
