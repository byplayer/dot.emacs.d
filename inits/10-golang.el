;;; package --- Summary
;; configuration for 10-golang
;;; Commentary:
;;; Code:
(require 'company)

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

(add-hook 'go-mode-hook
          '(lambda()
             (go-eldoc-setup)
             (company-mode)
             (flycheck-mode)
             (setq indent-level 4)
             (setq c-basic-offset 4)
             (setq tab-width 4)
             (define-key go-mode-map (kbd "C-c c") 'go-compile)
             (add-to-list (make-local-variable 'company-backends) '(company-go :with company-yasnippet))
             ))

(autoload 'helm-go-package "helm-go-package") ;; Not necessary if using ELPA package
(eval-after-load 'go-mode
  '(substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))

(use-package helm-godoc
  :quelpa (helm-godoc :fetcher github :repo "syohex/emacs-helm-godoc")
  :bind (:map go-mode-map
              ("C-c C-d" . helm-godoc)))

(use-package lv
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(provide '10-golang)
;;; 10-golang.el ends here
