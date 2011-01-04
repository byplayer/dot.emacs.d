(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/ac-dict")
(ac-config-default)

(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;; extentions
(require 'auto-complete-etags)
