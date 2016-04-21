(eval-after-load "go-mode"
  '(progn
     ;; auto-complete
     (require 'go-autocomplete)

     ;; company-mode
     (add-to-list 'company-backends 'company-go)

     ;; eldoc
     (add-hook 'go-mode-hook 'go-eldoc-setup)

     ;; key bindings
     (define-key go-mode-map (kbd "M-.") 'godef-jump)))
