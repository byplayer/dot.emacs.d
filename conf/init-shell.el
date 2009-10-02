(require 'shell)

(set-face-foreground 'comint-highlight-prompt "LightSkyBlue")
(set-face-bold-p 'comint-highlight-input nil)

(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; �G�R�[��~
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

;; shell-mode�ł͉�ʒ[�Ő܂�Ԃ�
(add-hook 'shell-mode-hook
          (lambda ()
            (custom-set-variables
             '(truncate-lines nil)
             '(truncate-partial-width-windows nil))))