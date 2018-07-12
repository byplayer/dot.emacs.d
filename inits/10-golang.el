(eval-after-load "go-mode"
  '(progn
     ;; auto-complete
     (require 'go-autocomplete)

     ;; company-mode
     (require 'company)
     (add-to-list 'company-backends 'company-go)

     ;; eldoc
     (add-hook 'go-mode-hook 'go-eldoc-setup)
     (add-hook 'go-mode-hook 'company-mode)
     (add-hook 'go-mode-hook 'flycheck-mode)

     ;; key bindings
     (define-key go-mode-map (kbd "M-.") 'godef-jump)))

(defun my/go-mode-hook ()
  (setq indent-level 4)
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (add-hook 'before-save-hook' 'gofmt-before-save))

(add-hook 'go-mode-hook 'my/go-mode-hook)
