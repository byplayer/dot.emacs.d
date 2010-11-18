;====================================
; 最近使ったファイル」を（メニューに）表示する
;====================================
(require 'recentf)
(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 100)
(setq recentf-exclude '("^/[^/:]+:" "/svn-commit\.tmp$"))
(recentf-mode 1)
; (global-set-key "\C-xf" 'recentf-open-files)
