
;; [[file:~/.spacemacs.d/spacemacs.org::*Layers%20to%20load][Layers\ to\ load:1]]

(setq-default
 dotspacemacs-configuration-layers
 '(
   auto-completion
   better-defaults
   c-c++
   cscope
   emacs-lisp
   emoji
   git
   go
   gtags
   helm
   html
   javascript
   markdown
   (mu4e :variables
         mu4e-installation-path "/usr/local/share/emacs/site-lisp/mu4e"
         )
   org
   ranger
   shell
   spell-checking
   syntax-checking
   python
   version-control
   yaml
   )
 )

;; Layers\ to\ load:1 ends here
