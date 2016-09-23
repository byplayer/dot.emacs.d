;;; package --- Summary
;; configuration for yaml mode
;;; Commentary:
;;; Code:
;; yaml-modeの設定
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.dag$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml-[a-zA-Z]+$" . yaml-mode))

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(provide '10-yaml)
;;; 10-yaml.el ends here
