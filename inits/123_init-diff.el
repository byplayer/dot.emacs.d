; add diff file next and diff hunk kill
(add-hook 'diff-mode-hook
  (lambda()
    (define-key diff-mode-map (kbd "C-M-n") 'diff-file-next)
    (define-key diff-mode-map (kbd "C-M-p") 'diff-file-prev)
    (define-key diff-mode-map (kbd "M-k") 'diff-hunk-kill)
    (define-key diff-mode-map (kbd "C-M-k") 'diff-file-kill)))
