
;; [[file:~/.spacemacs.d/spacemacs.org::*spacemacs.org][spacemacs\.org:1]]



;; spacemacs\.org:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Find%20this%20file][Find\ this\ file:1]]

(defun spacemacs/find-config-file ()
  (interactive)
  (find-file (concat dotspacemacs-directory "/spacemacs.org")))

(spacemacs/set-leader-keys "fec" 'spacemacs/find-config-file)

;; Find\ this\ file:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*General%20settings][General\ settings:1]]

;; Set some sane defaults
(setq-default
 indent-tabs-mode 't
 tab-width 8
 )

;; (defun no-junk-please-were-unixish ()
;;   (let ((coding-str (symbol-name buffer-file-coding-system)))
;;     (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
;;       (set-buffer-file-coding-system 'unix))))
;; (add-hook 'find-file-hooks 'no-junk-please-were-unixish)

;; Default settings
(spacemacs/toggle-spelling-checking-off)
(setq
 powerline-default-separator 'nil
 browse-url-generic-program "chrome-browser"
 ;; http://ergoemacs.org/emacs/emacs_set_default_browser.html
 browse-url-browser-function 'browse-url-chrome
 )
(defun helm-browse-url (url &rest args)
  (helm-generic-browser url "google-chrome"))

;; General\ settings:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Autocompletion][Autocompletion:1]]

(setq 
 auto-completion-return-key-behavior 'complete
 auto-completion-tab-key-behavior 'cycle
 auto-completion-complete-with-key-sequence nil
 auto-completion-complete-with-key-sequence-delay 0.1
 auto-completion-idle-delay 0.2
 auto-completion-private-snippets-directory nil
 auto-completion-enable-snippets-in-popup t
 auto-completion-enable-help-tooltip t
 auto-completion-enable-sort-by-usage nil
 )

;; Autocompletion:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*C-C%2B%2B][C-C++:1]]

(setq
 c-default-style '((java-mode . "java")
                   (awk-mode . "awk")
                   (python-mode . "python")
                   (other . "linux")
                   )
 )

;; C-C++:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*CScope][CScope:1]]

(define-key evil-normal-state-map (kbd "C-t") 'helm-cscope-pop-mark)

;; CScope:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Evil%20Mode][Evil\ Mode:1]]

(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

;; Evil\ Mode:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Magit][Magit:1]]

(global-git-commit-mode t)
(setq
 ;; https://magit.vc/manual/magit/Performance.html
 magit-revision-insert-related-refs nil
 magit-refresh-status-buffer 't
 magit-commit-show-diff nil
 magit-revert-buffers 1
 magit-default-tracking-name-function 'magit-default-tracking-name-branch-only
 magit-log-section-arguments (list "-n50" "--decorate")
 magit-log-cutoff-length 50
 magit-revision-insert-related-refs nil
 magit-repository-directories '(("~/Code/" . 2))
 )
(setq-default
 git-magit-status-fullscreen 't
 )
(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)

;; Magit:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*GitLink][GitLink:1]]

;; Git link Linux kernel
(defun git-link-linux (hostname dirname filename branch commit start end)
  (format "https://elixir.bootlin.com/linux/latest/source/%s"
          (concat filename
                  (when start
                    (concat "#L" (format "%s" start))))))

'(progn
   ;; Example parameter for:
   ;; hostname: git.kernel.org
   ;; dirname:  pub/scm/linux/kernel/git/torvalds/linux
   ;; filename: kernel/sched/pelt.c
   ;; branch:   lkml/utilclamp_v11_debug
   ;; commit:   a82eb017568a894b299341eb641fdd0f7ebbde91
   ;; start:    81
   ;; end:      nil
   (add-to-list 'git-link-remote-alist
                '("git\\.kernel\\.org" git-link-linux))
   ; (add-to-list 'git-link-commit-remote-alist
   ;                  '("git\\.kernel\\.org" git-link-commit-linux))
   )

;; GitLink:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Paradox][Paradox:1]]

(setq
 paradox-github-token 'bbf1492c1c91e67c1f672ed2fa755b3662574d65
 )

;; Paradox:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*GoLang][GoLang:1]]

;; The get a working installation and spacemacs integration:
;; 1. ensure to have the most recent version of go installed, usually under:
;;       /usr/local/go
;;    by following the installation instructions from, e.g.:
;;       https://golang.org/doc/install?download=go1.12.6.linux-amd64.tar.gz
;;
;; 2. symlink under a standard path to ensure spacemacs finds it
;;       $ sudo ln -s /usr/local/go/bin/go /usr/bin/go
;;
;; 3. open the go layer do (SPC h l RET go RET) and install all the required tools
;;    check they are all installed under the go workspace (~/go/bin)
;;
;; 4. for company-go autocompletion to work: make sure you have only one
;;    gocode binary, with:
;;       $ which -a gocode
;;    and that's the most updated version installed in your GOPATH, i.e.
;;       $ go get -u github.com/nsf/gocode
;;
;; The following two paths are to ensure we look at the most recently insalled
;; versions:

(add-to-list 'exec-path "/home/derkling/go/bin/")
(add-to-list 'exec-path "/usr/local/go/bin")
(setq
 go-use-golangci-lint t
 godoc-at-point-function 'godoc-gogetdoc
 ;; set this to nil if you’re using .editorconfig in your project
 go-tab-width 4
 ;; Force formatting every time we save
 ;; NOTE: this could lead to unused imports to be removed
 go-format-before-save t
 gofmt-command "goimports"
 )

;; GoLang:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Gtags][Gtags:1]]

(setq
 gtags-enable-by-default t
 )

;; Gtags:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Helm][Helm:1]]

(setq
 helm-M-x-fuzzy-match 't
 helm-position 'bottom
 helm-enable-auto-resize t
 )

;; Helm:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Keybindings][Keybindings:1]]

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; Keybindings:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*General%20Settings][General\ Settings:1]]

(with-eval-after-load 'mu4e

  ;; General user info
  (setq
   user-full-name         "Patrick Bellasi"
   user-mail-address      "patrick.bellasi@arm.com"
   mu4e-reply-to-address  "patrick.bellasi@arm.com"
   mu4e-user-mail-address-list '(
                                 "derkling@gmail.com"
                                 "patrick.bellasi@gmail.com"
                                 "patrick.bellasi@arm.com"
                                 )
   ;; mu4e-compose-complete-only-personal t
   ;; mu4e-compose-complete-only-after "2014-06-23"
   ;; mu4e-compose-complete-ingore-address-regext "no-?reply"
   )
  )

;; General\ Settings:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Mailboxes][Mailboxes:1]]

(with-eval-after-load 'mu4e
  (setq
   mu4e-maildir (expand-file-name "~/Mail/Work")  ;; top level maildir, cannot be a link
   mu4e-sent-folder   "/Sent Items"                       ;; folder for sent messages
   mu4e-drafts-folder "/Drafts"                   ;; unfinished messages
   mu4e-trash-folder  "/Deleted Items"            ;; trashed messages
   mu4e-refile-folder "/Archive"                  ;; saved messages
   )
  )

;; Mailboxes:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Bookmarks][Bookmarks:1]]

(with-eval-after-load 'mu4e
  (setq
   mu4e-maildir-shortcuts '(("/INBOX"             . ?i)
                            ("/Sent Items"        . ?s)
                            ("/Archive"   . ?a)
                            ("/Deleted Items"     . ?t)
                            ("/Drafts"    . ?d))
   )
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "LKML (last 2h)"
                :query "date:2h..now"
                :key ?k)
               t)
  )

;; Bookmarks:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Receiving%20Messages][Receiving\ Messages:1]]

(with-eval-after-load 'mu4e
  (setq
   mu4e-get-mail-command "mbsync work"
   mu4e-html2text-command "w3m -T text/html"
   mu4e-update-interval 120
   mu4e-headers-auto-update t
   )
  )

;; Receiving\ Messages:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*SpeedUp%20Indexing%20for%20large%20Mailboxes][SpeedUp\ Indexing\ for\ large\ Mailboxes:1]]

(with-eval-after-load 'mu4e
  (setq
   mu4e-index-cleanup nil ;; don't do a full cleanup check
   mu4e-index-lazy-check t        ;; don't consider up-to-date dirs
   )
  )

;; SpeedUp\ Indexing\ for\ large\ Mailboxes:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Customize%20Visualizations][Customize\ Visualizations:1]]

(with-eval-after-load 'mu4e
  (setq
   message-signature-file (expand-file-name "~/dotfiles/spacemacs/mu4e/signature")
   mu4e-attachment-dir "/tmp"
   mu4e-compose-signature-auto-include t
   mu4e-headers-date-format "%e-%b"
   mu4e-headers-include-related t
   mu4e-headers-time-format "%k:%M"
   mu4e-headers-skip-duplicates t
   mu4e-headers-visible-lines 10
   mu4e-view-auto-mark-as-read nil
   mu4e-headers-fields '(
                         (:flags . 6)
                         (:human-date . 12)
                         (:from . 24)
                         (:subject))
   mu4e-view-fields '(:subject :from :to :cc :date
                               :tags :attachments
                               :signature :decryption
                               :mailing-list :message-id)
   )
  )

;;; colorize patch-based emails
;(require 'mu4e-patch)
;(add-hook 'mu4e-view-mode-hook #'mu4e-patch-highlight)

;; Customize\ Visualizations:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Customize%20Actions][Customize\ Actions:1]]

(with-eval-after-load 'mu4e
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t)

  ;; ;; show images
  ;; (setq mu4e-show-images t)
  ;; ;; use imagemagick, if available
  ;; (when (fboundp 'imagemagick-register-types)
  ;;   (imagemagick-register-types))
  )

;; Customize\ Actions:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Sending%20Messages][Sending\ Messages:1]]

(with-eval-after-load 'mu4e
  (setq
   message-send-mail-function 'smtpmail-send-it
   smtpmail-starttls-credentials '(("foss.arm.com" 587 nil nil))
   smtpmail-default-smtp-server "foss.arm.com"
   smtpmail-smtp-server "foss.arm.com"
   smtpmail-smtp-service 587
   smtpmail-debug-info t
   )
  )

;; Sending\ Messages:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Customize%20sending][Customize\ sending:1]]

(with-eval-after-load 'mu4e

  (setq
   message-citation-line-function 'message-insert-formatted-citation-line
   message-citation-line-format "On %a, %b %d, %Y at %T %z, %f wrote...\n"
   message-signature-file (expand-file-name "~/dotfiles/emacs/mu4e/signature")
   mu4e-compose-signature-auto-include t
   ;; What do to for sent messages:
   ;; - sent   : copy into "Sent Items"
   ;; - delete : don't save message to Sent Messages, IMAP takes care of this
   mu4e-sent-messages-behavior 'sent
   )
  )

;; Customize\ sending:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Keybindings][Keybindings:1]]

(with-eval-after-load 'mu4e

                                        ; Spell checking
  (add-hook 'mu4e-compose-mode-hook
            (defun my-do-compose-stuff ()
              "My settings for message composition."
              (set-fill-column 72)
              (flyspell-mode))
            )
  )

;; Keybindings:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Keybindings][Keybindings:1]]

(with-eval-after-load 'mu4e
  (define-key 'mu4e-headers-mode-map (kbd "TAB") 'mu4e-headers-toggle-thread-folding)
  )

;; Keybindings:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*NeoTree][NeoTree:1]]

(setq
 neo-theme 'nerd
 )

;; NeoTree:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Org%20Mode][Org\ Mode:1]]

;; To get Org v9 working, these fixes could be required:
;;
;; - https://emacs.stackexchange.com/questions/32001/org-babel-9-spacemacs-unable-to-evaluate-org-babel-src-blocks
;;
;; cd .emacs.d/elpa/
;; # I suggest to run this without "delete" first.
;;   find org* -name "*.elc" -delete
;;
;; - https://emacs.stackexchange.com/questions/37692/how-to-fix-symbols-function-definition-is-void-org-babel-get-header
;;
;; replace (sh . t) by (shell . t) in your call of org-babel-do-load-languages

; (org-babel-do-load-languages 'org-babel-load-languages
;                            (append org-babel-load-languages
;                                    '((shell . t)
;                                      (python . t)
;                                      (C . t))))

(setq
 org-enable-sticky-header t
 org-projectile-file "TODOs.org"
 org-want-todo-bindings t
 org-clock-into-drawer "CLOCKING"
 org-default-notes-file (concat org-directory "/Notes.org")
 )

;; (setq-default
;;  dotspacemacs-configuration-layers '((org :variables org-projectile-file "TODOs.org"))
;;  )

;; (require 'org-projectile)
;; (mapcar '(lambda (file)
;;                 (when (file-exists-p file)
;;                   (push file org-agenda-files)))
;;              (org-projectile-todo-files))

;; Org\ Mode:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Shell][Shell:1]]

(setq
 shell-default-shell 'ansi-term
 shell-default-term-shell "/bin/zsh"
 shell-default-height 30
 shell-default-position 'bottom
 )

;; Shell:1 ends here

;; [[file:~/.spacemacs.d/spacemacs.org::*Spell%20checking][Spell\ checking:1]]

(setq
 spell-checking-enable-by-default nil
 enable-flyspell-auto-completion t
 )

;; Spell\ checking:1 ends here
