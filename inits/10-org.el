;;; package --- Summary
;;; Commentary:
;;; Code:

(setq org-todo-keywords 
  '((sequence "TODO(t)" "STARTED(!)" "WAITING(w@/!)" "|" "DONE(d!)")))

(setq org-todo-keyword-faces
  '(("TODO" . org-warning)
   ("STARTED" . "yellow")
   ("WAITING" . "orange")
   ("DONE" . "green")))

;; write done date
(setq org-log-done 'time)

(custom-set-variables
  '(org-display-custom-times t)
  '(org-time-stamp-custom-formats (quote ("<%Y.%m.%d>" . "<%Y.%m.%d %H:%M>")))
)

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

(provide '10-org)
;;; 10-org.el ends here
