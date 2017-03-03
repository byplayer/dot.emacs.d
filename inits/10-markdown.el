;;; package --- Summary
;;; Commentary:
;;; Code:
(setq auto-mode-alist
      (append '(
                ("\\.markdown$" . markdown-mode)
                ("\\.md$" . markdown-mode)
                ) auto-mode-alist))

(provide '10-markdown)
;;; 10-markdown.el ends here
