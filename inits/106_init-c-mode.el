(defun my-c-mode-hook ()
  (c-set-style "gnu")
  (c-set-offset 'statement-block-intro 2)
  (setq c-basic-offset 2)
  (turn-on-font-lock)
  (local-set-key "\C-cc" 'compile)
  (gtags-mode 1)
  (local-set-key  "\C-co" 'ff-find-other-file)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-hook)


