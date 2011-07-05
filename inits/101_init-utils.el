(require 'recentf-ext)

(defun copy-full-path-and-linenum ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (let
        ((msg  (format "copied: %s L:%d" (file-truename buffer-file-name) (line-number-at-pos))))

      (kill-new msg)
      (message msg))))

(global-set-key  "\C-cf" 'copy-full-path-and-linenum)
