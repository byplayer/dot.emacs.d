;; untabify-file turn off
(defun untabify-file-off (dummy)
  "turn off untabify-file"
  (interactive "p")
  (remove-hook 'write-file-hooks 'untabify-before-write))

;; untabify-file turn on
(defun untabify-file-on (dummy)
  "turn off untabify-file"
  (interactive "p")
  (add-hook 'write-file-hooks 'untabify-before-write))
