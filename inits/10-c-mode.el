;;; package --- Summary
;; configuration for c-mode
;;; Commentary:
;;; Code:
(require 'irony)

(defun my/c-mode-hook ()
  (c-set-offset 'statement-block-intro 2)
  (setq c-basic-offset 2)
  (turn-on-font-lock)
  (local-set-key "\C-cc" 'compile)
  (when (member major-mode irony-supported-major-modes)
    (irony-mode 1)))

(add-hook 'c-mode-common-hook 'my/c-mode-hook)
(add-hook 'irony-mode-hook
          (lambda()
            (irony-cdb-autosetup-compile-options)
            (add-to-list (make-local-variable 'company-backends) '(company-irony :with company-yasnippet))))

(setq flycheck-clang-language-standard "c++14")

(provide '10-c-mode)
;;; 10-c-mode ends here
