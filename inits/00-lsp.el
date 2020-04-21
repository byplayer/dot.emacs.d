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

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(provide '00-lsp)
;;; 00-lsp.el ends here
