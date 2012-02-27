(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/ac-dict")
(ac-config-default)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(add-to-list 'ac-modes 'yaml-mode)
(add-to-list 'ac-modes 'rhtml-mode)
(add-to-list 'ac-modes 'outline-mode)
(add-to-list 'ac-modes 'feature-mode)
(add-to-list 'ac-modes 'octave-mode)
(add-to-list 'ac-modes 'c-mode)
(add-to-list 'ac-modes 'c++-mode)
(add-to-list 'ac-modes 'emacs-lisp-mode)
(add-to-list 'ac-modes 'js2-mode)

(setq ac-sources '(ac-source-yasnippet
                   ac-source-dictionary
                   ac-source-gtags
                   ac-source-words-in-buffer))

;; (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
