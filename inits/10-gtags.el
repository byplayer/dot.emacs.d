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

;; for helm completion
(defun gtags-find-tag-for-helm (&optional other-win)
  "Input tag name and move to the definition."
  (interactive)
  (let (tagname prompt input)
    (setq tagname (gtags-current-token))
    (if tagname
      (setq prompt (concat "Find tag: (default " tagname ") "))
     (setq prompt "Find tag: "))
    (setq input (completing-read prompt 'gtags-completing-gtags
                  nil nil tagname gtags-history-list))
    (if (not (equal "" input))
      (setq tagname input))
    (gtags-push-context)
    (gtags-goto-tag tagname "" other-win)))

(define-key gtags-mode-map "\M-." 'gtags-find-tag-for-helm)
(define-key gtags-mode-map "\M-," 'gtags-find-rtag)
(define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
(define-key gtags-mode-map "\M-/" 'gtags-find-pattern)
(define-key gtags-mode-map "\M-*" 'gtags-pop-stack)

;; change synbol regexp for finding emacs function
(setq gtags-symbol-regexp "[A-Za-z_][A-Za-z_0-9---\?]*")
