;;; package --- Summary
;;; Commentary:
;;; Code:
;; flycheck
(require 'flycheck)
(require 'f)

(add-hook 'after-init-hook #'global-flycheck-mode)

(defvar flycheck-pos-tip-timeout)

(eval-after-load 'flycheck
  '(progn
     (flycheck-pos-tip-mode)
     (setq flycheck-display-errors-delay 0.5)
     (setq flycheck-pos-tip-timeout 60)
     (defun flycheck-print-current-checker (args)
       "Print checker for current buffer.
ARGS is dummy"
       (interactive "P")
       (print (flycheck-get-checker-for-buffer))
       )))

;; overwride chef-foodcritic checker to set next checkers
(flycheck-define-checker chef-foodcritic
  "A Chef cookbooks syntax checker using Foodcritic.

See URL `http://acrmp.github.io/foodcritic/'."
  :command ("foodcritic" source)
  :error-patterns
  ((error line-start (message) ": " (file-name) ":" line line-end))
  :modes (enh-ruby-mode ruby-mode)
  :predicate
  (lambda ()
    (let ((parent-dir (f-parent default-directory)))
      (or
       ;; Chef CookBook
       ;; http://docs.opscode.com/chef/knife.html#id38
       (locate-dominating-file parent-dir "recipes")
       ;; Knife Solo
       ;; http://matschaffer.github.io/knife-solo/#label-Init+command
       (locate-dominating-file parent-dir "cookbooks"))))
  :next-checkers ((warnings-only . ruby-rubocop)))

;; overwride python checkers to use custom python tool environment
(flycheck-define-checker python-flake8
  "A Python syntax and style checker using Flake8.

Requires Flake8 3.0 or newer. See URL
`https://flake8.readthedocs.io/'."
  ;; Not calling flake8 directly makes it easier to switch between different
  ;; Python versions; see https://github.com/flycheck/flycheck/issues/1055.
  :command ("flake8"
            "--format=default"
            (config-file "--config" flycheck-flake8rc)
            (option "--max-complexity" flycheck-flake8-maximum-complexity nil
                    flycheck-option-int)
            (option "--max-line-length" flycheck-flake8-maximum-line-length nil
                    flycheck-option-int)
            "-")
  :standard-input t
  :error-filter (lambda (errors)
                  (let ((errors (flycheck-sanitize-errors errors)))
                    (seq-map #'flycheck-flake8-fix-error-level errors)))
  :error-patterns
  ((warning line-start
            "stdin:" line ":" (optional column ":") " "
            (id (one-or-more (any alpha)) (one-or-more digit)) " "
            (message (one-or-more not-newline))
            line-end))
  :enabled (lambda ()
             (funcall flycheck-executable-find "flake8"))
  :modes python-mode
  :next-checkers (python-pylint))

(flycheck-define-checker python-pylint
  "A Python syntax and style checker using Pylint.

This syntax checker requires Pylint 1.0 or newer.

See URL `https://www.pylint.org/'."
  ;; --reports=n disables the scoring report.
  ;; Not calling pylint directly makes it easier to switch between different
  ;; Python versions; see https://github.com/flycheck/flycheck/issues/1055.
  :command ("pylint"
            "--reports=n"
            "--output-format=text"
            (eval (if flycheck-pylint-use-symbolic-id
                      "--msg-template={path}:{line}:{column}:{C}:{symbol}:{msg}"
                    "--msg-template={path}:{line}:{column}:{C}:{msg_id}:{msg}"))
            (config-file "--rcfile=" flycheck-pylintrc concat)
            ;; Need `source-inplace' for relative imports (e.g. `from .foo
            ;; import bar'), see https://github.com/flycheck/flycheck/issues/280
            source-inplace)
  :error-filter
  (lambda (errors)
    (flycheck-sanitize-errors (flycheck-increment-error-columns errors)))
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ":"
          (or "E" "F") ":"
          (id (one-or-more (not (any ":")))) ":"
          (message) line-end)
   (warning line-start (file-name) ":" line ":" column ":"
            (or "W" "R") ":"
            (id (one-or-more (not (any ":")))) ":"
            (message) line-end)
   (info line-start (file-name) ":" line ":" column ":"
         (or "C" "I") ":"
         (id (one-or-more (not (any ":")))) ":"
         (message) line-end))
  :enabled (lambda ()
             (funcall flycheck-executable-find "pylint"))
  :modes python-mode)

(provide '10-flycheck)
;;; 10-flycheck.el ends here
