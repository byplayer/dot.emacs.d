;;; package --- Summary
;;; Commentary:
;;; Code:


(leaf arduino-mode
  :ensure t)

(leaf cider
  :ensure t)

(leaf bind-key
  :ensure t
  :require t)

(leaf org-sticky-header
  :ensure t)

(leaf org
  :ensure t
  :after bind-key org-sticky-header
  :bind (("C-c a" . my/org-agenda)
         ("C-c C-9" . org-capture))
  :mode (("\\.org$" . org-mode))
  :pre-setq ((org-directory . "~/docs/org_doc")
             (org-plantuml-jar-path . "/usr/share/plantuml/plantuml.jar"))
  :defun (my/get-string-from-file my-org-agenda-files)
  :defvar (org-directory
           my-org-agenda-directory
           org-use-speed-commands
           org-todo-keywords
           org-log-done
           org-log-done-with-time
           org-log-reschedule
           org-agenda-restore-windows-after-quit
           org-agenda-show-all-dates
           org-indent-indentation-per-level
           org-startup-indented
           daily-routine-template
           org-agenda-files
           org-capture-templates
           org-archive-location
           org-startup-folded
           org-agenda-custom-commands
           helm-completing-read-handlers-alist
           org-plantuml-jar-path
           org-speed-commands
           org-confirm-babel-evaluate
           org-imenu-depth
           org-clock-clocktable-default-properties
           org-global-properties
           org-columns-default-format
           org-mode-map)
  :setq ((org-use-speed-commands . t)
         (org-log-done . 'time)
         (org-log-done-with-time . t)
         (org-log-reschedule . 'time)
         (org-agenda-restore-windows-after-quit . t)
         (org-agenda-show-all-dates . t)
         (org-indent-indentation-per-level . 2)
         (org-startup-indented . t)
         (org-startup-folded . "nofold")
         (org-imenu-depth . 3)
         (org-columns-default-format . "%40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM")
         )
  :hook ((org-mode-hook . (lambda () (add-to-list 'helm-completing-read-handlers-alist
                                                  '(org-set-tags))))
         (org-babel-after-execute-hook . org-redisplay-inline-images)
         (org-clock-in-prepare-hook . my/org-mode-ask-effort))
  :bind (org-mode-map
         ("C-a" . vc-like-home)
         ("C-c t" . org-todo)
         ("M-*" . org-mark-ring-last-goto)
         ("C-c n" . outline-next-visible-heading)
         ("C-c p" . outline-previous-visible-heading)
         ("C-c u" . outline-up-heading)
         ("C-c f" . org-forward-heading-same-level)
         ("C-c b" . org-backward-heading-same-level))
  :init
  (require 'org-habit)
  (require 'org-agenda)
  (require 'ido)

  (setq my-org-agenda-directory (cl-concatenate 'string org-directory "/agenda"))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCEL(c)")))

  (setq daily-routine-template
        (cl-concatenate 'string org-directory "/templates/daily_routine.org"))

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline (lambda()(cl-concatenate 'string my-org-agenda-directory "/todo.org")) "Tasks")
           "* TODO %?")
          ("m" "Memo" entry (file my/generate-org-memo-name)
           "* %?\nEntered on %T\n")
          ("d" "Doc" entry (file my/generate-org-doc-name)
           "* %?\nEntered on %T\n")
          ("l" "work log" entry (file+datetree
                            (lambda()
                              (format-time-string
                               (let (target_dir)
                                 (setq target_dir (format-time-string (cl-concatenate 'string org-directory "/log")))
                                 (unless (file-directory-p target_dir)
                                   (make-directory target_dir t))
                                 (cl-concatenate 'string target_dir "/work_log_myself_%Y.org")))))
           "* %^{description} %^g\n- %?")
          ("j" "members' log" entry (file+datetree
                            (lambda()
                              (format-time-string
                               (let (target_dir)
                                 (setq target_dir (format-time-string (cl-concatenate 'string org-directory "/log/members")))
                                 (unless (file-directory-p target_dir)
                                   (make-directory target_dir t))
                                 (cl-concatenate 'string target_dir
                                              "/work_log_" (my/pick-members) ".org")))))
           "* %^{description}\n- %?")))

  (setq org-archive-location
        (cl-concatenate 'string my-org-agenda-directory "/archive/"
                     (format-time-string "%Y" (current-time))
                     (format-time-string "/%Y%m_todo_archive.org::" (current-time))))

  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
  (setq org-clock-clocktable-default-properties '(:maxlevel 4 :scope file))
  (setq org-global-properties
        (quote (("Effort_ALL" .
                 "00:05 00:15 00:30 01:00 01:30 02:00 02:30 03:00 04:00 05:00 06:00 07:00 08:00"))))

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
  (org-babel-do-load-languages 'org-babel-load-languages
                               '(
                                 (shell . t)
                                 (plantuml . t)))

  (defun my/get-string-from-file (filePath)
    "Return filePath's file content."
    (with-temp-buffer
      (insert-file-contents filePath)
      (buffer-string)))

  (defun insert-daily-routine-tasks ()
     "Insert daily routine tasks"
     (interactive)
     (insert (format-time-string (my/get-string-from-file daily-routine-template))))

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
      (setq target_dir (format-time-string (cl-concatenate 'string org-directory "/memo/%Y/%Y%m")))
      (unless (file-directory-p target_dir)
        (make-directory target_dir t))
      (format "%s/%s-%s.org" target_dir (format-time-string "%Y%m%d-%H%M%S") name )))

  (defun my/generate-org-doc-name ()
    (let* ((name (read-string "Name: "))
           (target_dir))
      (setq target_dir (format-time-string (cl-concatenate 'string org-directory "/docs/%Y")))
      (unless (file-directory-p target_dir)
        (make-directory target_dir t))
      (format "%s/%s_%s.org" target_dir (format-time-string "%Y%m%d") name )))

  (defun my/pick-members ()
    "Prompt user to pick a choice from a list."
    (interactive)
    (let ((choices (split-string (with-temp-buffer
                                   (insert-file-contents-literally "~/.members")
                                   (buffer-substring-no-properties (point-min) (point-max))))))
      (ido-completing-read "Choose member:" choices )))

  (defun my-org-confirm-babel-evaluate (lang body)
    (not (member lang '("plantuml" "sh"))))

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

  (defun my/org-mode-ask-effort ()
    "Ask for an effort estimate when clocking in."
    (unless (org-entry-get (point) "Effort")
      (let ((effort
             (completing-read
              "Effort: "
              (org-entry-get-multivalued-property (point) "Effort"))))
        (unless (equal effort "")
          (org-set-property "Effort" effort)))))

  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  :config
  (bind-keys :map org-agenda-mode-map
             ("d" . org-agenda-todo))
  (add-to-list 'org-speed-commands '("d" org-todo "DONE"))
  (add-to-list 'org-speed-commands '("c" org-todo "CANCEL"))
  (add-to-list 'org-speed-commands '("C" org-clone-subtree-with-time-shift 1))
  (add-to-list 'org-speed-commands '("D" org-deadline ""))
  (add-to-list 'org-speed-commands '("A" my/org-archive-this-file))
  (add-to-list 'org-speed-commands '("s" org-schedule ""))
  (add-to-list 'org-speed-commands '("/" helm-org-in-buffer-headings)))

(leaf org-sticky-header
  :ensure t
  :hook (org-mode-hook . org-sticky-header-mode)
  :defvar (org-sticky-header-full-path)
  :setq ((org-sticky-header-full-path . 'full)))

(leaf org-todoist
  :el-get byplayer/org-todoist
  :after (org)
  :commands org-todoist-fetch org-todoist-list
  :defvar (org-todoist-agenda-file)
  :config
  (setq org-todoist-agenda-file (expand-file-name "todoist.org" my-org-agenda-directory)))

(provide '10-org)
;;; 10-org.el ends here
