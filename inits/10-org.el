;;; package --- Summary
;;; Commentary:
;;; Code:

(setq my-org-agenda-directory "~/docs/org/agenda/")

(setq org-directory "~/docs/org")
(setq org-agenda-files (list my-org-agenda-directory))

(defun my-org-capture-advice (func &rest args)
   (let ((org-default-notes-file
         (format-time-string "~/docs/org/captured/%Y%m%d-%H%M%S.org")))
    (apply func args)))

(advice-add 'org-capture :around #'my-org-capture-advice)

(global-set-key "\C-ca" 'org-agenda)

(provide '10-org)
;;; 10-org.el ends here
