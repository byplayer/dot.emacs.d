;;; package --- Summary
;;; Commentary:
;;; Code:

(eval-after-load "ruby-mode"
  '(progn
     (setq ruby-command "ruby")))

;; set path environment
(add-to-list 'exec-path "/usr/local/git/bin")
(add-to-list 'exec-path "/usr/local/ruby/bin")

(provide 'linux-env)
;;; linux-env.el ends here
