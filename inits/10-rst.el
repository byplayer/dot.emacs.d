(setq auto-mode-alist
      (append '(
                ("\\.markdown$" . rst-mode)
                ("\\.md$" . rst-mode)
                ) auto-mode-alist))
