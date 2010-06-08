(require 'shell)

(set-face-foreground 'comint-highlight-prompt "LightSkyBlue")
(set-face-bold-p 'comint-highlight-input nil)

;; �G�R�[��~
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

;; shell-mode�ł͉�ʒ[�Ő܂�Ԃ�
(add-hook 'shell-mode-hook
          (lambda ()
            (custom-set-variables
             '(truncate-lines nil)
             '(truncate-partial-width-windows nil))))