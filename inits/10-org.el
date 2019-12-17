;;; package --- Summary
;;; Commentary:
;;; Code:


(use-package arduino-mode
  :ensure t)

(use-package cider
  :ensure t)

(use-package org
  :ensure t
  :bind (("C-c a" . my/org-agenda)
         ("C-c C-9" . org-capture))
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
   org-agenda-show-all-dates t
   org-indent-indentation-per-level 2
   org-startup-indented t)

  (add-hook 'org-mode-hook
            (lambda () (add-to-list 'helm-completing-read-handlers-alist '(org-set-tags))))

  (setq org-directory "~/docs/org_doc")
  (setq my-org-agenda-directory (concatenate 'string org-directory "/agenda"))
  (setq daily-routine-template (concatenate 'string org-directory "/templates/daily_routine.org"))
  (defun my-org-agenda-files ()
    (directory-files-recursively my-org-agenda-directory "\.org$"))

  (setq org-agenda-files
        (my-org-agenda-files))

  (defun my/org-agenda (&optional arg org-keys restriction)
    (interactive "P")
    (let ()
      (setq org-agenda-files
            (my-org-agenda-files))
      (require 'org-agenda)
      (org-agenda)))

  (defun my/generate-org-memo-name ()
    (let* ((name (read-string "Name: "))
           (target_dir))
      (setq target_dir (format-time-string (concatenate 'string org-directory "/memo/%Y/%Y%m")))
      (unless (file-directory-p target_dir)
        (make-directory target_dir t))
      (format "%s/%s-%s.org" target_dir (format-time-string "%Y%m%d-%H%M%S") name )))

  (defun my/generate-org-doc-name ()
    (let* ((name (read-string "Name: "))
           (target_dir))
      (setq target_dir (format-time-string (concatenate 'string org-directory "/docs/%Y")))
      (unless (file-directory-p target_dir)
        (make-directory target_dir t))
      (format "%s/%s_%s.org" target_dir (format-time-string "%Y%m%d") name )))

  (require 'ido)
  (defun my/pick-members ()
    "Prompt user to pick a choice from a list."
    (interactive)
    (let ((choices (split-string (with-temp-buffer
                                   (insert-file-contents-literally "~/.members")
                                   (buffer-substring-no-properties (point-min) (point-max))))))
      (ido-completing-read "Choose member:" choices )))

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline (lambda()(concatenate 'string my-org-agenda-directory "/todo.org")) "Tasks")
           "* TODO %?")
          ("m" "Memo" entry (file my/generate-org-memo-name)
           "* %?\nEntered on %T\n")
          ("d" "Doc" entry (file my/generate-org-doc-name)
           "* %?\nEntered on %T\n")
          ("l" "my log" entry (file+datetree
                            (lambda()
                              (format-time-string
                               (let (target_dir)
                                 (setq target_dir (format-time-string (concatenate 'string org-directory "/log")))
                                 (unless (file-directory-p target_dir)
                                   (make-directory target_dir t))
                                 (concatenate 'string target_dir "/work_log_myself_%Y.org")))))
           "* %^{description} %^g\n- %?")
          ("j" "members' log" entry (file+datetree
                            (lambda()
                              (format-time-string
                               (let (target_dir)
                                 (setq target_dir (format-time-string (concatenate 'string org-directory "/log/members")))
                                 (unless (file-directory-p target_dir)
                                   (make-directory target_dir t))
                                 (concatenate 'string target_dir
                                              "/work_log_" (my/pick-members) ".org")))))
           "* %^{description}\n- %?")))

  (setq org-archive-location
        (concatenate 'string my-org-agenda-directory "/archive/"
                     (format-time-string "%Y" (current-time))
                     (format-time-string "/%Y%m_todo_archive.org::" (current-time))))

  ;; show content as default view
  ;; #+STARTUP: fold              (or ‘overview’, this is equivalent)
  ;; #+STARTUP: nofold            (or ‘showall’, this is equivalent)
  ;; #+STARTUP: content
  ;; #+STARTUP: showeverything
  (setq org-startup-folded "nofold")

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
                 ((org-agenda-start-day "-3d")
                 (org-agenda-span 9)
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
  (add-to-list 'org-agenda-custom-commands
               '("c" "TaskChute TODO"
                 tags-todo "+SCHEDULED<\"<tomorrow>\"+TODO=\"TODO\""
                 ((org-agenda-span 'day)
                  (org-agenda-start-on-weekday 0)
                                        ; (org-agenda-overriding-header "TaskChute TODO")
                  (org-agenda-overriding-columns-format "%50ITEM(Task) %10Effort(Effort){:}")
                  (org-agenda-view-columns-initially t))
                 ))

  (defun my-org-confirm-babel-evaluate (lang body)
  (not (member lang '("plantuml" "sh"))))
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

  (setq org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
  (org-babel-do-load-languages 'org-babel-load-languages
                               '(
                                 (shell . t)
                                 (plantuml . t)
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
                 "00:05 00:15 00:30 01:00 01:30 02:00 02:30 03:00 04:00 05:00 06:00 07:00 08:00"))))

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

  (setq org-columns-default-format "%40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM")

  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

  (defun my/get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

  (defun insert-daily-routine-tasks ()
     "Insert daily routine tasks"
     (interactive)
     (insert (format-time-string (my/get-string-from-file daily-routine-template))))

  :config
  (bind-keys :map org-mode-map
             ("C-a" . vc-like-home)
             ("C-c t" . org-todo)
             ("M-*" . org-mark-ring-last-goto)
             ("C-c n" . outline-next-visible-heading)
             ("C-c p" . outline-previous-visible-heading)
             ("C-c u" . outline-up-heading)
             ("C-c f" . org-forward-heading-same-level)
             ("C-c b" . org-backward-heading-same-level))
  (bind-keys :map org-agenda-mode-map
             ("d" . org-agenda-todo))
  )

(use-package org-gcal
  :ensure t
  :quelpa t
  :commands (org-gcal-fetch)
  :config
  (load "~/.org-gcal/org-gcal-conf")
  (setq org-gcal-up-days 1
        org-gcal-down-days 3
        org-gcal-auto-archive nil
        org-gcal-dir "~/.org-gcal"
        org-gcal-token-file (expand-file-name ".org-gcal-token" org-gcal-dir)
        org-gcal-notify-p nil)

  ;; monkey patch to treat calendar event as TODO and add prefix [MTG] and set time as scheduled
  (defun org-gcal--update-entry (calendar-id event)
    "\
Update the entry at the current heading with information from EVENT, which is
parsed from the Calendar API JSON response using
‘org-gcal--json-read’. Point must be located on an Org-mode heading line or
an error will be thrown. Point is not preserved."
    (unless (org-at-heading-p)
      (user-error "Must be on Org-mode heading."))
    (let* ((smry  (or (plist-get event :summary)
                      "busy"))
           (desc  (plist-get event :description))
           (loc   (plist-get event :location))
           (_link  (plist-get event :htmlLink))
           (meet  (plist-get event :hangoutLink))
           (etag (plist-get event :etag))
           (event-id    (plist-get event :id))
           (stime (plist-get (plist-get event :start)
                             :dateTime))
           (etime (plist-get (plist-get event :end)
                             :dateTime))
           (sday  (plist-get (plist-get event :start)
                             :date))
           (eday  (plist-get (plist-get event :end)
                             :date))
           (start (if stime stime sday))
           (end   (if etime etime eday))
           (elem))
      (when loc (replace-regexp-in-string "\n" ", " loc))
      (org-edit-headline (concat "[MTG]" smry))
      (looking-at org-complex-heading-regexp)
      (unless (match-string 2)
        (org-edit-headline (concat "TODO [MTG]" smry)))
      (org-entry-put (point) org-gcal-etag-property etag)
      (when loc (org-entry-put (point) "LOCATION" loc))
      (when meet
        (org-entry-put
         (point)
         "HANGOUTS"
         (format "[[%s][%s]]"
                 meet
                 "Join Hangouts Meet")))
      (org-entry-put (point) org-gcal-calendar-id-property calendar-id)
      (org-gcal--put-id (point) calendar-id event-id)
      ;; Insert event time and description in :ORG-GCAL: drawer, erasing the
      ;; current contents.
      (org-gcal--back-to-heading)
      (setq elem (org-element-at-point))
      (save-excursion
        (when (re-search-forward
               (format
                "^[ \t]*:%s:[^z-a]*?\n[ \t]*:END:[ \t]*\n?"
                (regexp-quote org-gcal-drawer-name))
               (save-excursion (outline-next-heading) (point))
               'noerror)
          (replace-match "" 'fixedcase)))
      (unless (re-search-forward ":PROPERTIES:[^z-a]*?:END:"
                                 (save-excursion (outline-next-heading) (point))
                                 'noerror)
        (message "PROPERTIES not found: %s (%s) %d"
                 (buffer-name) (buffer-file-name) (point)))
      (end-of-line)
      (newline)
      (insert (format ":%s:" org-gcal-drawer-name))
      (newline)
      (let*
          ((timestamp
            (if (or (string= start end) (org-gcal--alldayp start end))
                (org-gcal--format-iso2org start)
              (if (and
                   (= (plist-get (org-gcal--parse-date start) :year)
                      (plist-get (org-gcal--parse-date end)   :year))
                   (= (plist-get (org-gcal--parse-date start) :mon)
                      (plist-get (org-gcal--parse-date end)   :mon))
                   (= (plist-get (org-gcal--parse-date start) :day)
                      (plist-get (org-gcal--parse-date end)   :day)))
                  (format "<%s-%s>"
                          (org-gcal--format-date start "%Y-%m-%d %a %H:%M")
                          (org-gcal--format-date end "%H:%M"))
                (format "%s--%s"
                        (org-gcal--format-iso2org start)
                        (org-gcal--format-iso2org
                         (if (< 11 (length end))
                             end
                           (org-gcal--iso-previous-day end))))))))
        (if (org-element-property :scheduled elem)
            (org-schedule nil timestamp)
          (org-schedule nil timestamp)
          (newline)
          (when desc (newline))))
      ;; Insert event description if present.
      (when desc
        (insert (replace-regexp-in-string "^\*" "✱" desc))
        (insert (if (string= "\n" (org-gcal--safe-substring desc -1)) "" "\n")))
      (insert ":END:"))))

(use-package org-sticky-header
  :ensure t
  :quelpa t
  :hook (org-mode . org-sticky-header-mode)
  :config (setq org-sticky-header-full-path 'full))

(use-package org-todoist
  :ensure t
  :quelpa (org-todoist :fetcher file :path "~/projects/private/org-todoist")
  :config
  (setq org-todoist-agenda-file (expand-file-name "todoist.org" my-org-agenda-directory)))

(provide '10-org)
;;; 10-org.el ends here
