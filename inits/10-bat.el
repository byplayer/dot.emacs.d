;;; package --- Summary
;;; Commentary:
;;; Code:

(setq auto-mode-alist
       (append
        (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
        ;; For DOS init files
        (list (cons "CONFIG\\."   'bat-mode))
        (list (cons "AUTOEXEC\\." 'bat-mode))
        auto-mode-alist))

(autoload 'bat-mode "bat-mode"
      "DOS and Windows BAT files" t)

(provide '10-bat)
;;; 10-bat.el ends here
