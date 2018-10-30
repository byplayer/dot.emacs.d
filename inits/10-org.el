;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'org-habit)

;; TODO status
(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; log date when down
(setq org-log-done 'time)

(setq org-directory "~/docs/org")
(setq my-org-agenda-directory (concatenate 'string org-directory "/agenda"))

(setq org-agenda-files
          (cl-delete-if (lambda (k)
                          (string-match-p "\\/\\(report\\|archive\\)\\/" k))
                        (directory-files-recursively org-directory "\.org$")))

(defun my/org-agenda (&optional arg org-keys restriction)
  (interactive "P")
  (let ()
    (setq org-agenda-files
          (cl-delete-if (lambda (k)
                          (string-match-p "\\/\\(report\\|archive\\)\\/" k))
                        (directory-files-recursively org-directory "\.org$")))
    (org-agenda)))


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

(global-set-key "\C-ca" 'my/org-agenda)

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-a") 'vc-like-home)
            (define-key org-mode-map (kbd "C-c t") 'org-todo)))

;; show content as default view
;; #+STARTUP: fold              (or ‘overview’, this is equivalent)
;; #+STARTUP: nofold            (or ‘showall’, this is equivalent)
;; #+STARTUP: content
;; #+STARTUP: showeverything
(setq org-startup-folded t)

(require 'org-agenda)
(add-to-list 'org-agenda-custom-commands
             '("w" "Weekly review"
               agenda ""
               ((org-agenda-span 'week)
                (org-agenda-start-on-weekday 0)
                (org-agenda-start-with-log-mode t)
                (org-agenda-skip-function
                 '(org-agenda-skip-entry-if 'nottodo 'done))
                )))
(add-to-list 'org-agenda-custom-commands
             '("r" "Review monthly tasks"
               agenda ""
               ((org-agenda-start-day "-31d")
                (org-agenda-span 33)
                (org-agenda-start-on-weekday 0)
                (org-agenda-start-with-log-mode t)
                (org-agenda-skip-function
                 '(org-agenda-skip-entry-if 'nottodo 'done))
                )))


(provide '10-org)
;;; 10-org.el ends here
