;;; package --- Summary
;;; Commentary:
;;; Code:

;; TODO status
(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; log date when down
(setq org-log-done 'time)


(setq org-directory "~/docs/org")
(setq my-org-agenda-directory (concatenate 'string org-directory "/agenda"))
(setq org-agenda-files (list my-org-agenda-directory))

(defun my/generate-org-memo-name ()
  (let* ((name (read-string "Name: "))
         (target_dir))
    (setq target_dir (format-time-string (concatenate 'string org-directory "/memo/%Y/%Y%m")))
    (unless (file-directory-p target_dir)
      (make-directory target_dir t))
    (format "%s/%s-%s.org" target_dir (format-time-string "%Y%m%d-%H%M%S") name )))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concatenate 'string my-org-agenda-directory "/todo.org") "Tasks")
             "* TODO %?")
        ("m" "Memo" entry (file (my/generate-org-memo-name))
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
            (define-key org-mode-map (kbd "C-a") 'vc-like-home)
            (define-key org-mode-map (kbd "C-c t") 'org-todo)))

;; show content as default view
(setq org-startup-folded 'content)

(provide '10-org)
;;; 10-org.el ends here
