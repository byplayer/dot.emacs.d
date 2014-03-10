(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/html/") load-path))

;; html-helper-mode
(add-hook 'html-helper-load-hook '(lambda () (require 'html-font)))
(add-hook 'html-helper-mode-hook '(lambda () (font-lock-mode 1)))

(setq html-helper-basic-offset 2)
(setq html-helper-item-continue-indent 0)

(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons
                       '("\\.html$" . html-helper-mode)
                       auto-mode-alist))

;; css-mode
(defun my-css-mode-hook ()
  (c-set-style "gnu")
  (c-set-offset 'statement-block-intro 2)
  (setq c-basic-offset 2)
  (turn-on-font-lock))

(add-hook 'css-mode-hook 'my-css-mode-hook)

(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons
                       '("\\.css$" . css-mode) auto-mode-alist))

(setq cssm-indent-level 2)
(setq cssm-indent-function #'cssm-c-style-indenter)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (gtags-mode 1)
             (require 'js)
             (setq tab-width 4
                   js-indent-level 4
                   js-expr-indent-offset 4
                   indent-tabs-mode t
                   js2-cleanup-whitespace nil
                   skeleton-pair 1)
             (define-key js2-mode-map "\C-m" 'newline-and-indent)
             (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
             (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)))

(defun indent-and-back-to-indentation ()
  (interactive)
  (indent-for-tab-command)
  (let ((point-of-indentation
         (save-excursion
           (back-to-indentation)
           (point))))
    (skip-chars-forward "\s " point-of-indentation)))
