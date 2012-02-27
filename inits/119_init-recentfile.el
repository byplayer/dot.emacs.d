; show recent file menu
(require 'recentf)
(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 300)
(setq recentf-exclude '("^/[^/:]+:" "/svn-commit\.tmp$"))
(recentf-mode 1)

