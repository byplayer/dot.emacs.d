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
                   '(width . 205) ;; ウィンドウ幅
                   '(height . 68) ;; ウィンドウの高さ
                   ; '(top . 60) ;;表示位置
                   ; '(left . 140) ;;表示位置
                   '(line-spae 0)
                   )
                  initial-frame-alist)))

;====================================
; スクロール設定
;====================================
(setq scroll-conservatively 35
  scroll-margin 0
  scroll-step 4) ;4行ずつスクロールする

;====================================
; カーソル移動設定
;====================================
(add-to-list 'load-path "~/.emacs.d/elisp/physical-line/")

;カーソル移動を論理行ではなく、物理行（見たまま）単位で移動する。
(require 'physical-line)
(setq-default physical-line-mode t)
;; dired-mode は論理行移動のままにする.
(setq physical-line-ignoring-mode-list '(dired-mode))


;; ツールバーを隠す
(tool-bar-mode nil)

(add-to-list 'load-path "~/.emacs.d/elisp/color-theme/")
(when (require 'color-theme nil t)
  (color-theme-initialize)

  ;; load additional color-theme
  (setq old-init-loader-default-regexp init-loader-default-regexp)
  (setq init-loader-default-regexp "\\(?:^color-theme-\\)")
  (init-loader-load "~/.emacs.d/elisp/color-theme-optional/")
  (setq init-loader-default-regexp old-init-loader-default-regexp))



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

(set-face-bold-p 'font-lock-warning-face nil)
(setq default-frame-alist initial-frame-alist)
;
(set-face-foreground 'escape-glyph "aquamarine3")
(set-face-foreground 'link "LightSkyBlue")

(setq ansi-color-names-vector
      ["black" "dark red" "DarkOliveGreen3" "NavajoWhite2" "LightSkyBlue" "dark magenta"
       "DarkSlateGray2" "white"])


;; 行番号表示
;; wb-line-number
;; 重いので削除
;; (require 'wb-line-number)

;; (setq truncate-partial-width-windows nil)
;; (set-scroll-bar-mode nil)
;; (setq wb-line-number-scroll-bar t)

;; (wb-line-number-enable)
;; (custom-set-faces
;;  '(wb-line-number-face ((t (:foreground "light gray"))))
;;  '(wb-line-number-scroll-bar-face
;;    ((t (:foreground "black" :background "light gray")))))
;; (global-set-key "\C-x3" 'wb-line-number-split-window-horizontally)
