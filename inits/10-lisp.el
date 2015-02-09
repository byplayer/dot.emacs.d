;;; package --- Summary
;;; Commentary:
;;; Code:
(add-hook 'emacs-lisp-mode-hook
          '(lambda()
             (progn
               (setq indent-tabs-mode nil)
               (flyspell-prog-mode)
               (rainbow-mode))))

(add-hook 'lisp-mode-hook
          '(lambda()
             (progn
               (setq indent-tabs-mode nil)
               (flyspell-prog-mode)
               (rainbow-mode))))

;;; 10-lisp.el ends here
