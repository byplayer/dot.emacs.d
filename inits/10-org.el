;;; package --- Summary
;;; Commentary:
;;; Code:


(use-package arduino-mode
  :ensure t)

(use-package cider
  :ensure t)

(use-package org
  :ensure t
  :bind (("C-c a" . my/org-agenda))
  :init
  (require 'org-habit)
  (setq org-use-speed-commands t)

  ;; TODO status
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCEL(c)")))
  ;; log date when down
  (setq
   org-log-done 'time
   org-log-done-with-time t
   org-log-reschedule 'time
   org-agenda-restore-windows-after-quit t
   org-agenda-show-all-dates t)

  (add-hook 'org-mode-hook
            (lambda () (add-to-list 'helm-completing-read-handlers-alist '(org-set-tags))))

  (setq org-directory "~/docs/org_doc")
  (setq my-org-agenda-directory (concatenate 'string org-directory "/agenda"))
  (defun my-org-agenda-files ()
    (directory-files-recursively my-org-agenda-directory "\.org$"))

  (setq org-agenda-files
        (my-org-agenda-files))

  (defun my/org-agenda (&optional arg org-keys restriction)
    (interactive "P")
    (let ()
      (setq org-agenda-files
            (my-org-agenda-files))
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

  (setq org-archive-location
        (concatenate 'string my-org-agenda-directory "/archive/"
                     (format-time-string "%Y" (current-time))
                     (format-time-string "/%Y%m_todo_archive.org::" (current-time))))

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
               '("d" "Daily todo tasks"
                 ((agenda "") (alltodo ""))
                 ((org-agenda-span 'day)
                  (org-agenda-start-on-weekday 0)
                  (org-agenda-start-with-log-mode nil)
                  )))
    (add-to-list 'org-agenda-custom-commands
               '("l" "upcoming tasks"
                 agenda ""
                 ((org-agenda-start-day "-2d")
                 (org-agenda-span 8)
                 (org-agenda-start-on-weekday nil)
                  (org-agenda-start-with-log-mode nil)
                  )))
  (add-to-list 'org-agenda-custom-commands
               '("w" "Weekly review tasks"
                 agenda ""
                 ((org-agenda-span 'week)
                  (org-agenda-start-on-weekday 0)
                  (org-agenda-start-with-log-mode t)
                  ;; (org-agenda-skip-function
                  ;;  '(org-agenda-skip-entry-if 'nottodo 'done))
                  )))
  (add-to-list 'org-agenda-custom-commands
               '("r" "Review monthly tasks"
                 agenda ""
                 ((org-agenda-start-day "-31d")
                  (org-agenda-span 33)
                  (org-agenda-start-on-weekday 0)
                  (org-agenda-start-with-log-mode t)
                  ;; (org-agenda-skip-function
                  ;;  '(org-agenda-skip-entry-if 'nottodo 'done))
                  )))

  (org-babel-do-load-languages 'org-babel-load-languages
                               '(
                                 (shell . t)
                                 )
                               )

  (add-to-list 'org-speed-commands-user '("d" org-todo "DONE"))
  (add-to-list 'org-speed-commands-user '("c" org-todo "CANCEL"))
  (add-to-list 'org-speed-commands-user '("C" org-clone-subtree-with-time-shift 1))
  (add-to-list 'org-speed-commands-user '("D" org-deadline ""))
  (add-to-list 'org-speed-commands-user '("A" my/org-archive-this-file))
  (add-to-list 'org-speed-commands-user '("s" org-schedule ""))
  (add-to-list 'org-speed-commands-user '("/" helm-org-in-buffer-headings))

  (setq org-imenu-depth 3)

  (setq org-clock-clocktable-default-properties '(:maxlevel 4 :scope file))
  (setq org-global-properties
        (quote (("Effort_ALL" .
                 "00:05 00:10 00:15 00:30 01:00 01:30 02:00 02:30 03:00 04:00 05:00 06:00 07:00 08:00"))))

  (defun my/org-archive-this-file ()
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

  (defun my/org-update-clocktable-in-file ()
    "Update org clocktable in the file."
    (interactive)
    (let* ((old-cursor-pos (point)))
      (goto-char (point-min))
      (if (search-forward "#+BEGIN: clocktable" nil t nil)
          (progn
            (org-clock-report)
            (goto-char old-cursor-pos))
        (progn
          (goto-char old-cursor-pos)
          (org-clock-report)
          ))))

  (add-hook 'org-clock-in-prepare-hook
            'my/org-mode-ask-effort)

  (defun my/org-mode-ask-effort ()
    "Ask for an effort estimate when clocking in."
    (unless (org-entry-get (point) "Effort")
      (let ((effort
             (completing-read
              "Effort: "
              (org-entry-get-multivalued-property (point) "Effort"))))
        (unless (equal effort "")
          (org-set-property "Effort" effort)))))

  (setq org-columns-default-format "%40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM"))
(provide '10-org)
;;; 10-org.el ends here
