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

(provide '10-flycheck)
;;; 10-flycheck.el ends here
