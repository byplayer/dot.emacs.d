;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'popwin)
(popwin-mode 1)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config '(("*compilation*" :noselect t)
                                      ("^\*helm.+\*$" :regexp t :height 0.4)
                                      ("*my helm*" :regexp t :height 0.4)
                                      ))
(push '("*rspec-compilation*" :regexp t) popwin:special-display-config)

(define-key global-map (kbd "C-x p") 'popwin:display-last-buffer)

(provide '00-popwin)
;;; 00-popwin.el ends here
