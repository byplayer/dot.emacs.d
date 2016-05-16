;;; package --- Summary
;;; Commentary:
;;; Code:
(setq auto-mode-alist
      (append '(
                ("\\.markdown$" . rst-mode)
                ("\\.md$" . rst-mode)
                ) auto-mode-alist))

(provide '10-rst)
;;; 10-rst.el ends here
