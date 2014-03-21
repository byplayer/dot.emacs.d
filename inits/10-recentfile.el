;;; package --- Summary
;;; Commentary:
;;; Code:
;; show recent file menu
(require 'recentf)
(require 'recentf-ext)

(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 500)
(setq recentf-exclude '("^/[^/:]+:" "/svn-commit\.tmp$" "COMMIT_EDITMSG"
                        "/bookmarks$"))
(recentf-mode 1)

(provide '10-recentfile)
;;; 10-recentfile.el ends here
