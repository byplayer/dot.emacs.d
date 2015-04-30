(require 'markdown-mode)
(setq auto-mode-alist
      (append '(
                ("\\.markdown$" . markdown-mode)
                ("\\.md$" . markdown-mode)
                ) auto-mode-alist))

(setq markdown-command "bluecloth")
