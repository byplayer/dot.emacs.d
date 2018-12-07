;;; package --- Summary
;; configuration for c-mode
;;; Commentary:
;;; Code:
(defun my-c-mode-hook ()
  (c-set-style "gnu")
  (c-set-offset 'statement-block-intro 2)
  (setq c-basic-offset 2)
  (turn-on-font-lock)
  (local-set-key "\C-cc" 'compile)
  (local-set-key  "\C-co" 'ff-find-other-file))

(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook
          '(lambda()
             (irony-cdb-autosetup-compile-options)
             (add-to-list (make-local-variable 'company-backends) '(company-irony :with company-yasnippet))))

(provide '10-c-mode)
;;; 10-c-mode ends here
