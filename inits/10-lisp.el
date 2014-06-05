;;; package --- Summary
;;; Commentary:
;;; Code:
(add-hook 'emacs-lisp-mode-hook
          '(lambda()
             (progn
               (setq indent-tabs-mode nil))))

(add-hook 'lisp-mode-hook
          '(lambda()
             (progn
               (setq indent-tabs-mode nil))))
;;; 128_init-lisp.el ends here
