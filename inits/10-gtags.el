(require 'gtags)
(require 'helm-gtags)

;; auto update gtags files
(defun my-c-mode-update-gtags ()
  (let* ((file (buffer-file-name (current-buffer)))
     (dir (directory-file-name (file-name-directory file))))
    (when (executable-find "global")
      (if (string= (shell-command-to-string "pgrep gtags") "")
          (start-process "gtags-update" nil
                         "global" "-uv")))))

(add-hook 'after-save-hook 'my-c-mode-update-gtags)

(defun my-tag-mode-insert-hook ()
  (gtags-mode 1))

(add-hook 'js2-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'perl-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'php-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'c-mode-common-hook 'my-tag-mode-insert-hook)
(add-hook 'rhtml-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'feature-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'ruby-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'emacs-lisp-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'lisp-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'nxml-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'go-mode-hook 'my-tag-mode-insert-hook)
(add-hook 'python-mode-hook 'my-tag-mode-insert-hook)

(add-hook 'gtags-mode-hook
      '(lambda()
         (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
         (local-set-key (kbd "M-,") 'helm-gtags-find-rtag)
         (local-set-key (kbd "M-/") 'helm-gtags-find-pattern)
         (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
         (local-set-key (kbd "M-*") 'helm-gtags-pop-stack)))
