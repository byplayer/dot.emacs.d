; html関連用のパス設定
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/html/") load-path))

;; html-helper-mode の設定
(add-hook 'html-helper-load-hook '(lambda () (require 'html-font)))
(add-hook 'html-helper-mode-hook '(lambda () (font-lock-mode 1)))

(setq html-helper-basic-offset 2)
(setq html-helper-item-continue-indent 0)

(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons
                       '("\\.html$" . html-helper-mode)
                       auto-mode-alist))

;; css-mode の設定
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

(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/js2/") load-path))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))