;====================================
; 最近使ったファイル」を（メニューに）表示する
;====================================
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 20)
(global-set-key "\C-xf" 'recentf-open-files)
