(add-to-list 'load-path "/usr/local/global/share/gtags/")
(require 'gtags)
(define-key gtags-mode-map "\M-." 'gtags-find-tag)
(define-key gtags-mode-map "\M-," 'gtags-find-rtag)
(define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
(define-key gtags-mode-map "\M-/" 'gtags-find-pattern)
(define-key gtags-mode-map "\M-*" 'gtags-pop-stack)

;; change synbol regexp for finding emacs function
(setq gtags-symbol-regexp "[A-Za-z_][A-Za-z_0-9---\?]*")

