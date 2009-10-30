(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(setq auto-mode-alist
      (append '(
                ("\\.markdown$" . markdown-mode)
                ("\\.md$" . markdown-mode)
                ) auto-mode-alist))

(setq markdown-command "maruku")