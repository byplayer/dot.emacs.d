;;; package --- Summary
;;; Commentary:
;;; Code:
;; show recent file menu
(require 'recentf)
(require 'recentf-ext)

(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 2000)
(setq recentf-exclude (append recentf-exclude
                              '("^/[^/:]+:" "/svn-commit\.tmp$" "COMMIT_EDITMSG"
                                "bookmarks")))
(setq recentf-auto-cleanup 10)
(setq recentf-auto-save-timer
      (run-with-idle-timer 30 t 'recentf-save-list))
(recentf-mode 1)

(provide '10-recentfile)
;;; 10-recentfile.el ends here
