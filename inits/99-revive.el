;;; package --- Summary
;;; Commentary:
;;; Code:

;; revive.el
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(define-key ctl-x-map "F" 'resume)                        ; C-x F resume
(define-key ctl-x-map "K" 'wipe)                          ; C-x K kill
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; auto save
(resume) ; auto resume

(provide '99-revive)
;;; 99-revive.el ends here
