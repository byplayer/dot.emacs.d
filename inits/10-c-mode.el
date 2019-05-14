;;; package --- Summary
;; configuration for c-mode
;;; Commentary:
;;; Code:
(defun my-c-mode-hook ()
  (c-set-offset 'statement-block-intro 2)
  (setq c-basic-offset 2)
  (turn-on-font-lock)
  (local-set-key "\C-cc" 'compile)
  (local-set-key  "\C-co" 'ff-find-other-file)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(defun my-irony-mode-on ()
  ;; avoid enabling irony-mode in modes that inherits c-mode, e.g: php-mode
  (when (member major-mode irony-supported-major-modes)
    (irony-mode 1)))

(require 'irony)
(add-hook 'c-mode-hook 'my-irony-mode-on)
(add-hook 'c++-mode-hook 'my-irony-mode-on)
(add-hook 'objc-mode-hook 'my-irony-mode-on)
(add-hook 'irony-mode-hook
          '(lambda()
             (irony-cdb-autosetup-compile-options)
             (add-to-list (make-local-variable 'company-backends) '(company-irony :with company-yasnippet))))

(setq flycheck-clang-language-standard "c++14")

(provide '10-c-mode)
;;; 10-c-mode ends here
