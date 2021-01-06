;;; package --- Summary
;; configuration for lsp
;;; Commentary:
;;; Code:

(leaf lv
  :ensure t)

(leaf lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode-hook . lsp-deferred))

(add-hook 'lsp-mode-hook
          '(lambda()
              (local-set-key (kbd "M-*") 'xref-pop-marker-stack)
              (local-set-key (kbd "M-.") 'xref-find-definitions)
              (local-set-key (kbd "M-/") 'xref-find-references)))

(leaf lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode)

(provide '00-lsp)
;;; 00-lsp.el ends here
