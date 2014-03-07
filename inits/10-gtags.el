(add-to-list 'load-path "/usr/local/global/share/gtags/")
(require 'gtags)

;; auto update gtags files
(defun my-c-mode-update-gtags ()
  (let* ((file (buffer-file-name (current-buffer)))
     (dir (directory-file-name (file-name-directory file))))
    (when (executable-find "global")
      (if (string= (shell-command-to-string "pgrep gtags") "")
          (start-process "gtags-update" nil
                         "global" "-uv")))))

(add-hook 'after-save-hook
      'my-c-mode-update-gtags)

;; TODO
;; -(define-key gtags-mode-map "\M-/" 'gtags-find-pattern)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
         (local-set-key (kbd "M-,") 'helm-gtags-find-rtag)
         (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
         (local-set-key (kbd "M-*") 'helm-gtags-pop-stack)))

;; change synbol regexp for finding emacs function
(defun helm-gtags-token-at-point ()
  (save-excursion
    (let (start)
      (when (looking-at "[a-zA-Z0-9_]")
        (skip-chars-backward "a-zA-Z0-9_-")
        (setq start (point))
        (skip-chars-forward "a-zA-Z0-9_-")
        (buffer-substring-no-properties start (point))))))
