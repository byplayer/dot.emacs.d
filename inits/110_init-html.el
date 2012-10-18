(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/html/") load-path))

;; nxhtml for html
(load "~/.emacs.d/elisp/nxhtml/autostart")
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))

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

;; for js
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/js2-mode/") load-path))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (gtags-mode 1)
             (setq js2-bounce-indent-flag nil)
             (define-key js2-mode-map "\C-m" 'newline-and-indent)
             (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)))

(defun indent-and-back-to-indentation ()
  (interactive)
  (indent-for-tab-command)
  (let ((point-of-indentation
         (save-excursion
           (back-to-indentation)
           (point))))
    (skip-chars-forward "\s " point-of-indentation)))
