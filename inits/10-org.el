;;; package --- Summary
;;; Commentary:
;;; Code:


(use-package arduino-mode
  :ensure t)

(use-package cider
  :ensure t)

(require 'org)
(require 'org-habit)

(setq org-use-speed-commands t)

;; TODO status
(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; log date when down
(setq org-log-done 'time)
(setq org-log-done-with-time t)

(setq org-directory "~/docs/org_doc")
(setq my-org-agenda-directory (concatenate 'string org-directory "/agenda"))
(setq my-org-agenda-exludes "\\/\\(report\\|archive\\|goal_1on1\\|interview\\)\\/")

(setq org-agenda-files
          (cl-delete-if (lambda (k)
                          (string-match-p my-org-agenda-exludes k))
                        (directory-files-recursively org-directory "\.org$")))

(defun my/org-agenda (&optional arg org-keys restriction)
  (interactive "P")
  (let ()
    (setq org-agenda-files
          (cl-delete-if (lambda (k)
                          (string-match-p my-org-agenda-exludes k))
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
      '(("t" "Todo" entry (file+headline (lambda()(concatenate 'string my-org-agenda-directory "/todo.org")) "Tasks")
             "* TODO %?")
        ("m" "Memo" entry (file my/generate-org-memo-name)
         "* %?\nEntered on %T\n")
        ("l" "Log" entry (file
                          (lambda()
                            (format-time-string
                             (let (target_dir)
                               (setq target_dir (format-time-string (concatenate 'string org-directory "/log/%Y/%Y%m")))
                               (unless (file-directory-p target_dir)
                                 (make-directory target_dir t))
                               (concatenate 'string target_dir "/%Y%m%d.org")))))
         "* %?\nEntered on %T\n")
        ))

(global-set-key "\C-ca" 'my/org-agenda)

(setq org-archive-location
      (concatenate 'string org-directory "/archive/"
                   (format-time-string "%Y" (current-time))
                   (format-time-string "/%Y%m_archive.org::" (current-time))))

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-a") 'vc-like-home)
            (define-key org-mode-map (kbd "C-c t") 'org-todo)
            (define-key org-mode-map (kbd "M-*") 'org-mark-ring-goto)))

;; show content as default view
;; #+STARTUP: fold              (or ‘overview’, this is equivalent)
;; #+STARTUP: nofold            (or ‘showall’, this is equivalent)
;; #+STARTUP: content
;; #+STARTUP: showeverything
(setq org-startup-folded "nofold")

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

(org-babel-do-load-languages 'org-babel-load-languages
                             '(
                               (shell . t)
                               )
                             )

(add-to-list 'org-speed-commands-user '("d" org-todo "DONE"))
(add-to-list 'org-speed-commands-user '("D" org-deadline ""))
(add-to-list 'org-speed-commands-user '("A" org-archive-this-file))
(add-to-list 'org-speed-commands-user '("s" org-schedule ""))

(defun org-archive-this-file ()
  "Archive current file.
The file-path is archive target file path.  If no file-path is given uses the function `buffer-file-name'."
  (interactive)
  (let* ((archive-path (format "%s/archive/%s/" org-directory (format-time-string "%Y")))
         (file-path buffer-file-name))
  (save-buffer)
  (when (y-or-n-p (format "Wil you archive %s?" file-path))
    (rename-file file-path archive-path)
    (kill-buffer)
    (message "Archived %s to %s" file-path archive-path)
    )))

(provide '10-org)
;;; 10-org.el ends here
