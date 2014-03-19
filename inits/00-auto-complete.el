(require 'auto-complete-config)
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
(add-to-list 'ac-modes 'nsis-mode)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'nxml-mode)

(setq ac-sources '(ac-source-yasnippet
                   ac-source-dictionary
                   ac-source-gtags
                   ac-source-words-in-buffer))

(defun ac-emacs-lisp-mode-setup ()
  (setq ac-sources '(ac-source-symbols
                     ac-source-words-in-same-mode-buffers
                     ac-source-yasnippet
                     ac-source-gtags
                     ac-source-dictionary)))

(defun ac-c++-mode-setup ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
                     ac-source-yasnippet
                     ac-source-semantic
                     ac-source-gtags
                     ac-source-dictionary)))

(defun ac-c-mode-setup ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
                     ac-source-yasnippet
                     ac-source-semantic
                     ac-source-gtags
                     ac-source-dictionary)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key (kbd "C-c m") 'ac-complete-semantic)))


;; (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
