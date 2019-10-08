;; -:wqa*- mode: emacs-lisp; lexical-binding: t; eval: (evil-close-folds); -*-

(defun dotspacemacs/layers ()

  (let ((fp (concat dotspacemacs-directory "spacemacs-defaults.elc")))
    (load fp)
    )

  (let ((fp (concat dotspacemacs-directory "spacemacs-layers.elc")))
    (load fp)
    )

  (setq-default
   dotspacemacs-additional-packages '()
   )

  (setq-default
   dotspacemacs-frozen-packages '()
   )

  (setq-default
   dotspacemacs-excluded-packages '()
   )
  )

(defun dotspacemacs/init ()
  (let ((fp (concat dotspacemacs-directory "spacemacs-init.elc")))
    (load fp))
  )

(defun dotspacemacs/user-env ()
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-load ()
  )

(defun dotspacemacs/user-init ()
  (let ((fp (concat dotspacemacs-directory "user-init.elc")))
    (load fp))
  )

(defun dotspacemacs/user-config ()
  (let ((fp (concat dotspacemacs-directory "user-config.elc")))
    (load fp))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  )
