;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

(setq ac-auto-show-menu 0.5)

;; C-n/C-p for select list
(setq ac-use-menu-map t)

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
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'rabbit-mode)

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

(defun ac-quick-help-force ()
  "Show auto-complete help."
  (interactive)
  (ac-quick-help t))
(define-key ac-completing-map (kbd "C-h") 'ac-quick-help-force)
(setq ac-dwim t)


(provide '00-auto-complete)
;;; 00-auto-complete.el ends here
