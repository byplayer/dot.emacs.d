;;; package --- Summary
;;; Commentary:
;;; Code:

(add-hook 'java-mode-hook
          (lambda ()
            (c-set-style "java")
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 4)))

(provide '10-java)
;;; 10-java.el ends here
