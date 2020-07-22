;;; package --- Summary
;;; Commentary:
;;; Code:

(setq confirm-kill-emacs 'y-or-n-p)
(set-frame-parameter nil 'fullscreen 'maximized)

;; revive
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(define-key ctl-x-map "F" 'resume)                        ; C-x F resume
(define-key ctl-x-map "K" 'kill-all-buffers)              ; C-x K kill
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; auto save
(resume) ; auto resume

(provide '99-misc)
;;; 99-misc.el ends here
