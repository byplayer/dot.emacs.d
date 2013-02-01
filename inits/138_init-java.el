(add-hook 'java-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq indent-tabs-mode t)
            (setq c-basic-offset 4)))