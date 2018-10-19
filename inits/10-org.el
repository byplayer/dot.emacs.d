;;; package --- Summary
;;; Commentary:
;;; Code:


(setq org-directory "~/docs/org")
(setq my-org-agenda-directory (concatenate 'string org-directory "/agenda"))
(setq org-agenda-files (list my-org-agenda-directory))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concatenate 'string my-org-agenda-directory "/todo.org") "Tasks")
             "* TODO %?")
        ("m" "Memo" entry (file
                           (format-time-string
                            (let (target_dir)
                              (setq target_dir (format-time-string (concatenate 'string org-directory "/memo/%Y/%Y%m")))
                              (unless (file-directory-p target_dir)
                                (make-directory target_dir t))
                              (concatenate 'string target_dir "/%Y%m%d-%H%M%S.org"))))
         "* %?\nEntered on %T\n")
        ("l" "Log" entry (file
                           (format-time-string
                            (let (target_dir)
                              (setq target_dir (format-time-string (concatenate 'string org-directory "/log/%Y/%Y%m")))
                              (unless (file-directory-p target_dir)
                                (make-directory target_dir t))
                              (concatenate 'string target_dir "/%Y%m%d.org"))))
         "* %?\nEntered on %T\n")
        ))

(global-set-key "\C-ca" 'org-agenda)

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-a") 'vc-like-home)))

(provide '10-org)
;;; 10-org.el ends here
