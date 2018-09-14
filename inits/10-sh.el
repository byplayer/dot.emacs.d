;;; package --- Summary
;;; Commentary:
;;; Code:

(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2
                  sh-indentation 2
                  sh-indent-after-continuation nil
                  sh-indent-for-continuation 0)
            ))

(provide '10-sh)
;;; 10-sh.el ends here
