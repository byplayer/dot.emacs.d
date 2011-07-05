(require 'recentf-ext)

(defun copy-full-path-to-kill-ring ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))
    (message "copied: %s" buffer-file-name)
    ))

(global-set-key  "\C-cf" 'copy-full-path-to-kill-ring)
