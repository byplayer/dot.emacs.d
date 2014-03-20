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

(provide '10-flycheck)
;;; 10-flycheck.el ends here
