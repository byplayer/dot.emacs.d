;;; package --- Summary
;; configuration for c-mode
;;; Commentary:
;;; Code:
(require 'google-c-style)
(require 'clang-format)

(setq clang-format-style "google")

;; clang-format-on-save
(defun my-clang-format-before-save ()
  "Usage: (add-hook 'before-save-hook 'my-clang-format-before-save)"

  (interactive)
  (if (or (eq major-mode 'c++-mode)
          (eq major-mode 'c-mode))
      (clang-format-buffer))
  )
(add-hook 'before-save-hook #'my-clang-format-before-save)

(defun my-c-mode-hook ()
  (c-set-offset 'statement-block-intro 2)
  (google-set-c-style)
  (google-make-newline-indent)
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
