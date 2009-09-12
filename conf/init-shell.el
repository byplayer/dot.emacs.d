(require 'shell)

(set-face-foreground 'comint-highlight-prompt "LightSkyBlue")
(set-face-bold-p 'comint-highlight-input nil)

;; エコー停止
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

;; shell-modeでは画面端で折り返す
(add-hook 'shell-mode-hook
          (lambda ()
            (custom-set-variables
             '(truncate-lines nil)
             '(truncate-partial-width-windows nil))))