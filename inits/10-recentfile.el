;;; package --- Summary
;;; Commentary:
;;; Code:
;; show recent file menu
(require 'recentf)
(require 'recentf-ext)

(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 2000)
(add-to-list 'recentf-exclude "^/[^/:]+:")
(add-to-list 'recentf-exclude "svn-commit\.tmp$")
(add-to-list 'recentf-exclude "COMMIT_EDITMSG")
(add-to-list 'recentf-exclude "bookmarks")
(add-to-list 'recentf-exclude "\\.recentf")
(add-to-list 'recentf-exclude "\\.revive\\.el")
(setq recentf-auto-cleanup 10)
(setq recentf-auto-save-timer
      (run-with-idle-timer 30 t 'recentf-save-list))
(recentf-mode 1)

(provide '10-recentfile)
;;; 10-recentfile.el ends here
