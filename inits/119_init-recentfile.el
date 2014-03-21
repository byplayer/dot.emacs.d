; show recent file menu
(require 'recentf)
(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 500)
(setq recentf-exclude '("^/[^/:]+:" "/svn-commit\.tmp$" "COMMIT_EDITMSG"))
(recentf-mode 1)

