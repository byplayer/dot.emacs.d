;;; package --- Summary
;; configuration for lsp
;;; Commentary:
;;; Code:

(use-package lv
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

(add-hook 'lsp-mode-hook
          '(lambda()
              (local-set-key (kbd "M-*") 'xref-pop-marker-stack)
              (local-set-key (kbd "M-.") 'xref-find-definitions)
              (local-set-key (kbd "M-/") 'xref-find-references)))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(provide '00-lsp)
;;; 00-lsp.el ends here
