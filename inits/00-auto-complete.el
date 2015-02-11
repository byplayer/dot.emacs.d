;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

(setq ac-auto-show-menu 0.5)

(eval-after-load "auto-complete"
  '(progn
      (ac-ispell-setup)))

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
(add-to-list 'ac-modes 'rst-mode)



(defun my-setup-ac-source ()
  (setq ac-sources (append '(ac-source-words-in-buffer
                             ac-source-yasnippet
                             ac-source-dictionary
                             ac-source-words-in-buffer
                             ac-source-words-in-same-mode-buffers
                             )))
  (ac-ispell-ac-setup)
  )

(mapc
 (lambda (hook)
   (add-hook hook 'my-setup-ac-source))
 '(
   yaml-mode-hook
   rhtml-mode-hook
   outline-mode-hook
   text-mode-hook
   rst-mode-hook
   nxml-mode-hook
   ))

(defun my-setup-ac-program-source ()
  (my-setup-ac-source)
  (setq ac-sources '(ac-source-symbols
                     ac-source-gtags)))

(mapc
 (lambda (hook)
   (add-hook hook 'my-setup-ac-program-source))
 '(
   c-mode-hook
   c++-mode-hook
   emacs-lisp-mode-hook
   lisp-mode-hook
   nsis-mode-hook
   ruby-mode-hook
   java-mode-hook
   ))

(defun ac-quick-help-force ()
  "Show auto-complete help."
  (interactive)
  (ac-quick-help t))
(define-key ac-completing-map (kbd "C-h") 'ac-quick-help-force)
(setq ac-dwim t)

(provide '00-auto-complete)
;;; 00-auto-complete.el ends here
