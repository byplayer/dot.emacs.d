(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/ac-dict")
(ac-config-default)

(add-to-list 'ac-modes 'yaml-mode)
(add-to-list 'ac-modes 'rhtml-mode)
(add-to-list 'ac-modes 'outline-mode)

;; (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;; extentions
(require 'auto-complete-etags)
