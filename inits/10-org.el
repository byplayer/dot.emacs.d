;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'org-habit)

(setq org-todo-keywords 
  '((sequence "TODO(t)" "STARTED(!)" "WAITING(w@/!)" "|" "DONE(d!)")))

(setq org-todo-keyword-faces
  '(("TODO" . "orange red")
   ("STARTED" . "yellow")
   ("WAITING" . "orange")
   ("DONE" . "lime green")))

;; write done date
(setq org-log-done 'time)


(defun sacha/org-clock-in-if-starting ()
  "Clock in when the task is marked STARTED."
  (when (and (string= org-state "STARTED")
             (not (string= org-last-state org-state)))
    (org-clock-in)))

(add-hook 'org-after-todo-state-change-hook
          'sacha/org-clock-in-if-starting)

(defadvice org-clock-in (after sacha activate)
  "Set this task's status to 'STARTED'."
  (org-todo "STARTED"))

(defun sacha/org-clock-out-if-waiting ()
  "Clock in when the task is marked STARTED."
  (when (and (string= org-state "WAITING")
             (not (string= org-last-state org-state)))
    (org-clock-out)))

(add-hook 'org-after-todo-state-change-hook
          'sacha/org-clock-out-if-waiting)

(setq org-agenda-files (list (expand-file-name "~/projects/misc/goal/agenda")))
(setq org-capture-templates
      '(("p" "Project Task" entry
         (file+headline (expand-file-name "~/projects/misc/goal/agenda/project.org") "Inbox")
         "** TODO %?\n    %i\n    %a\n    %T")
        ("t" "TODO" entry
         (file+headline "~/projects/misc/goal/agenda/todo.org" "Inbox")
         "** TODO %?\n    CAPTURED_AT: %a\n    %i")))

(global-set-key "\C-caa" 'org-agenda)
(global-set-key "\C-cap" 'org-capture)

(provide '10-org)
;;; 10-org.el ends here
