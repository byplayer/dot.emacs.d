; load first
(eval-after-load "untabify-file"
  '(progn
     (remove-hook 'write-file-hooks 'untabify-before-write)))
