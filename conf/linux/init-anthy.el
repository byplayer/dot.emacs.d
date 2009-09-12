;===================================
; Anthy
; CTRL-\で入力モード切替え
;===================================
(load-library "anthy")
(setq default-input-method "japanese-anthy")
(global-set-key "\C-\\" 'anthy-mode)

;変換時の文字の色
(set-face-foreground 'anthy-highlight-face "black")
;アンダーライン消去 
(set-face-underline 'anthy-highlight-face nil)
(set-face-underline 'anthy-underline-face nil)
(set-face-background 'anthy-underline-face "dark blue")
