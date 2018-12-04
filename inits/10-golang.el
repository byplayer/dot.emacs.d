;; company-mode
(require 'company)
(add-to-list 'company-backends 'company-go)

(defun go-compile ()
  "Traveling up the path, find build.xml file and run compile."
  (interactive)
  (save-buffer)
  (with-temp-buffer
    (while (and (not (or (file-exists-p "go.mod")
                         (file-directory-p ".git")))
        (not (equal "/" default-directory)))
      (cd ".."))
    (call-interactively 'compile)))

(defun my/go-mode-hook ()
  (setq indent-level 4)
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (define-key go-mode-map (kbd "C-c c") 'go-compile)
  )

(add-hook 'before-save-hook #'gofmt-before-save)

(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook 'my/go-mode-hook)

(autoload 'helm-go-package "helm-go-package") ;; Not necessary if using ELPA package
(eval-after-load 'go-mode
  '(substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))

(add-to-list 'load-path "~/.emacs.d/elisp/emacs-helm-godoc/")
(autoload 'helm-godoc "helm-godoc" nil t)
(define-key go-mode-map (kbd "C-c C-d") 'helm-godoc)
