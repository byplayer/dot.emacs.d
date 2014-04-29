;;; package --- Summary
;;; Commentary:
;;; Code:
;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(progn
     (custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
     (setq flycheck-display-errors-delay 0.3)))

(defun flycheck-print-current-checker (args)
  "Print checker for current buffer.
ARGS is dummy"
  (interactive "P")
  (print (flycheck-get-checker-for-buffer))
  )

(provide '10-flycheck)
;;; 10-flycheck.el ends here
