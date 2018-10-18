;;; package --- Summary
;;; Commentary:
;;; Code:

(setq my-org-agenda-directory "~/docs/org/agenda/")

(setq org-directory "~/docs/org")
(setq org-agenda-files (list my-org-agenda-directory))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/docs/org/agenda/gtd.org" "Tasks")
             "* TODO %?")
        ("m" "Memo" entry (file+datetree "~/docs/org/memo.org")
             "* %?\nEntered on %T\n")))

(global-set-key "\C-ca" 'org-agenda)

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-a") 'vc-like-home)))

(provide '10-org)
;;; 10-org.el ends here
