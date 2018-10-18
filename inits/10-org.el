;;; package --- Summary
;;; Commentary:
;;; Code:

(setq my-org-agenda-directory "~/docs/org/agenda/")

(setq org-directory "~/docs/org")
(setq org-default-notes-file "captured.org")
(setq org-agenda-files (list my-org-agenda-directory))

(global-set-key "\C-ca" 'org-agenda)

(provide '10-org)
;;; 10-org.el ends here
