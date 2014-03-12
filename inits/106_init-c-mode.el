(defun my-c-mode-hook ()
  (c-set-style "gnu")
  (c-set-offset 'statement-block-intro 2)
  (setq c-basic-offset 2)
  (turn-on-font-lock)
  (local-set-key "\C-cc" 'compile)
  (local-set-key  "\C-co" 'ff-find-other-file)

  (make-variable-buffer-local 'skeleton-pair)
  (make-variable-buffer-local 'skeleton-pair-on-word)
  (setq skeleton-pair-on-word t)
  (setq skeleton-pair t)
  (make-variable-buffer-local 'skeleton-pair-alist)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-hook)


