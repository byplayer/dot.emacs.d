;;; org-todoist.el --- Org sync with todoist

;; Author: byplayer <byplayer100@gmail.com>
;; URL: https://github.com/byplayer/org-todoist
;; Package-Version: 20200708.131629
;; Package-X-Original-Version: 20200708.1
;; Version: 0.2
;; Maintainer: byplayer <byplayer100@gmail.com>
;; Copyright (C) :2019 byplayer all rights reserved.
;; Package-Requires: ((request-deferred "20181129") (emacs "26"))
;; Keywords: convenience,

;;; Commentary:
;;
;; Put the org-todoist.el to your
;; load-path.
;; Add to init.el:
;; (require 'org-todoist)
;;
;;; Changelog:
;; 2019-12-17 Implement to fetch todoist data
;; 2020-07-08 Fix scheduled date issue when time isn't set on todoist

(require 'request-deferred)

;; Customization
;;; Code:

(defgroup org-todoist nil "Org sync with todoist"
  :tag "Org todoist todo"
  :group 'org)

(defcustom org-todoist-dir
  (expand-file-name ".org-todoist" user-emacs-directory)
  "Directory in which to save todoist token file."
  :group 'org-todoist
  :type 'string)

(defcustom org-todoist-token-file
  (expand-file-name ".org-todoist-token" org-todoist-dir)
  "File in which to save todoist token."
  :group 'org-todoist
  :type 'string)

(defcustom org-todoist-agenda-file
  (expand-file-name "todoist.org" org-todoist-dir)
  "The file to store todoist tasks."
  :group 'org-todoist
  :type 'string)

(defcustom org-todoist-title-format
  "* TODO %s"
  "The format to create title.
%s is replaced by item content."
  :group 'org-todoist
  :type 'string)

(defcustom org-todoist-client-id nil
  "Client ID for todoist OAuth."
  :group 'org-todoist
  :type 'string)

(defcustom org-todoist-client-secret nil
  "Client secret key for todoist OAuth."
  :group 'org-todoist
  :type 'string)

(defcustom org-tooist-item-id-property "item-id"
  "Org-mode property name on org-todoist entries that records the item id."
  :group 'org-todoist
  :type 'string)

(defvar org-todoist-token-plist nil
  "Token plist for org-todoist.")

;;;###autoload
(defun org-todoist-fetch (&optional token)
  "Sync tasks from todoist.
Using TOKEN to sync todo from todoist."
  (interactive)
  (org-todoist-ensure-token)
  (let ((token (plist-get org-todoist-token-plist :access_token)))
    (request
      "https://api.todoist.com/sync/v8/sync"
      :type "POST"
      :data `(("token" . ,token)
              ("sync_token" . "*") ("resource_types" . "[\"all\"]"))
      :parser 'json-read
      :success (cl-function
                (lambda (&key data &allow-other-keys)
                  (org-todoist-write-data data)
                  (message "fetch todoist tasks was done."))))
    ))

(defun org-todoist-write-data (result_data)
  "Write todoist data to the file.
RESULT_DATA is todoist API result."
  (let
      ((items '())
       (due nil)
       (local-tz (org-todoist-dig result_data '(user tz_info gmt_string))))
    (unless local-tz
      (setq local-tz "+0000"))
    (message "local-tz:%s" local-tz)
    (with-temp-file org-todoist-agenda-file
      (cl-loop for item in (append (alist-get 'items result_data) nil) do
               (insert (format org-todoist-title-format (alist-get 'content item)))
               (newline)
               (setq due (alist-get 'due item))
               (if (and due (alist-get 'date due))
                   (progn
                     (insert (format "SCHEDULED: %s"
                                     (org-todoist-convert-due-date-to-user-tz
                                      (alist-get 'date due)
                                      local-tz)))
                     (newline)))
               (insert ":PROPERTIES:")
               (newline)
               (insert (format ":%s: %s" org-tooist-item-id-property (alist-get 'id item)))
               (newline)
               (insert ":END:")
               (newline)
               (insert ":org-todoist:")
               (newline)
               (insert ":END:")
               (newline)
               ))))

(defun org-todoist-ensure-token ()
  "Ensure todoist token."
  (cond
   (org-todoist-token-plist t)
   ((and (file-exists-p org-todoist-token-file)
         (ignore-errors
           (setq org-todoist-token-plist
                 (with-temp-buffer
                   (insert-file-contents org-todoist-token-file)
                   (plist-get (read (current-buffer)) :token))))) t)))

(defun org-todoist-dig (list keys)
  "To get value from list.
You can pass list to keys.
If value is nil, return nil.
LIST is target list to get value.
KEYS is key list to retrieve data."
  (if list
      (if (= 1 (length keys))
          (alist-get (car keys) list)
        (org-todoist-dig (alist-get (car keys) list) (cdr keys)))
    nil))

(defun org-todoist-make-org-due (tz-data)
  "Convert timezone data to org due date format string.
Expected org date format as <%Y-%m-%d %a HH:mm>
TZ-DATA is list of (year month day time_str).
The time_str is expected HH:MM:SS"
  (let ((tz-time))
    (if (nth 3 tz-data)
        (progn
          (setq tz-time (append (timezone-parse-time (nth 3 tz-data)) nil))
          (format "<%04d-%02d-%02d %02d:%02d>"
                  (string-to-number (nth 0 tz-data))
                  (string-to-number (nth 1 tz-data))
                  (string-to-number (nth 2 tz-data))
                  (string-to-number (nth 0 tz-time))
                  (string-to-number (nth 1 tz-time))))
      (format "<%04d-%02d-%02d>"
              (string-to-number (nth 0 tz-data))
              (string-to-number (nth 1 tz-data))
              (string-to-number (nth 2 tz-data))))))

(defun org-todoist-convert-due-date-to-user-tz (due local-tz)
  "Convert todoist due time to user timezone time.
DUE is the value of due date.
LOCAL-TZ is user local timezone(+0800 etc)."
  (let ((due-date))
    (if due
        (if (= 10 (length due))
            (format "<%s>" due)
          (progn
            (setq due-date (append (timezone-parse-date due) nil))
            (if (nth 4 due-date)
                (progn
                  (setq due-date
                        (append (timezone-fix-time due nil local-tz) nil))
                  (format "<%04d-%02d-%02d %02d:%02d>"
                          (nth 0 due-date)
                          (nth 1 due-date)
                          (nth 2 due-date)
                          (nth 3 due-date)
                          (nth 4 due-date))
                  )
              (progn
                (org-todoist-make-org-due due-date)
                )
              )
            )
          )
      nil)))

(provide 'org-todoist)

;;; org-todoist.el ends here
