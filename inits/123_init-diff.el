; set color for diff mode
(add-hook 'diff-mode-hook
          (lambda ()
            (set-face-foreground 'diff-context-face "grey50")
            (set-face-background 'diff-header-face "black")
            (set-face-underline-p 'diff-header-face t)
            (set-face-foreground 'diff-file-header-face "MediumSeaGreen")
            (set-face-background 'diff-file-header-face "black")
            (set-face-foreground 'diff-index-face "MediumSeaGreen")
            (set-face-background 'diff-index-face "black")
            (set-face-foreground 'diff-hunk-header-face "plum")
            (set-face-background 'diff-hunk-header-face"black")
            (set-face-foreground 'diff-removed-face "pink")
            (set-face-background 'diff-removed-face "gray5")
            (set-face-foreground 'diff-added-face "light green")
            (set-face-foreground 'diff-added-face "white")
            (set-face-background 'diff-added-face "SaddleBrown")
            (set-face-foreground 'diff-changed-face "DeepSkyBlue1")))

; add diff file next and diff hunk kill
(add-hook 'diff-mode-hook
  (lambda()
    (define-key diff-mode-map (kbd "C-M-n") 'diff-file-next)
    (define-key diff-mode-map (kbd "C-M-p") 'diff-file-prev)
    (define-key diff-mode-map (kbd "M-k") 'diff-hunk-kill)
    (define-key diff-mode-map (kbd "C-M-k") 'diff-file-kill)))
