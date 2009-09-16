; 選択範囲（リージョン）をハイライト
(transient-mark-mode 1)

; 対応する｛｝をハイライト
(show-paren-mode 1)

;; シンタックスハイライトを有効にする
(global-font-lock-mode t)

;; font-lockでの装飾レベル
(setq font-lock-maximum-decoration t)
(setq fast-lock nil)
(setq lazy-lock nil)
(setq jit-lock t)

; 色設定
;; region の色
(set-face-background 'region "snow3")
(set-face-foreground 'region "black")

(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(foreground-color . "light gray") ;; 文字が白
                   '(background-color . "black") ;; 背景は黒
                   '(border-color     . "black")
                   '(mouse-color      . "light gray")
                   '(cursor-color     . "light gray")
                   ; '(cursor-type      . hairline-caret)
                   '(menu-bar-lines . 1)
                   ; '(font . "MS Mincho 12")
                   ;; 東雲なら shinonome16-fontset などを指定
                   ; '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
                   '(width . 202) ;; ウィンドウ幅
                   '(height . 77) ;; ウィンドウの高さ
                   ; '(top . 60) ;;表示位置
                   ; '(left . 140) ;;表示位置
                   )
                  initial-frame-alist)))

(set-face-foreground 'font-lock-comment-face "NavajoWhite2")
(set-face-foreground 'font-lock-string-face "tomato2")
(set-face-foreground 'font-lock-keyword-face "DarkSeaGreen3")
(set-face-foreground 'font-lock-constant-face "aquamarine3")
(set-face-foreground 'font-lock-type-face "DarkOliveGreen3")
(set-face-foreground 'font-lock-variable-name-face "burlywood3")

(set-face-foreground 'minibuffer-prompt "LightSkyBlue")

;; 警告系
(require 'flymake)
(set-face-foreground 'flymake-errline "black")
(set-face-foreground 'flymake-warnline "black")

; grep で見つかったファイル名など
(set-face-bold-p 'compilation-info nil)
(set-face-foreground 'compilation-info "DarkOliveGreen3")

; コンパイルの警告
(set-face-bold-p 'compilation-warning nil)
(set-face-foreground 'compilation-warning "NavajoWhite2")

(set-face-bold-p 'font-lock-warning-face nil)
(setq default-frame-alist initial-frame-alist)

;
(set-face-foreground 'escape-glyph "aquamarine3")
(set-face-foreground 'link "LightSkyBlue")

(setq ansi-color-names-vector
      ["black" "dark red" "DarkOliveGreen3" "NavajoWhite2" "LightSkyBlue" "dark magenta"
       "DarkSlateGray2" "white"])