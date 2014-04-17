;;; package --- Summary
;;; Commentary:
;;; Code:
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

(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(menu-bar-lines . 1)
                   ; '(font . "MS Mincho 12")
                   ;; 東雲なら shinonome16-fontset などを指定
                   ; '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
                   '(width . 205) ;; ウィンドウ幅
                   '(height . 71) ;; ウィンドウの高さ
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
(set-default 'truncate-lines t)
(setq visual-line-mode nil)
(setq line-move-visual nil)

(when (require 'color-theme nil t)
  (color-theme-initialize)

  ;; load additional color-theme
  (setq old-init-loader-default-regexp init-loader-default-regexp)
  (setq init-loader-default-regexp "\\(?:^color-theme-\\)")
  (init-loader-load "~/.emacs.d/elisp/color-theme-optional/")
  (setq init-loader-default-regexp old-init-loader-default-regexp)
  (color-theme-byplayer))

;; text-scale
(global-set-key (kbd "<C-mouse-4>") 'text-scale-decrease)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-6>") 'text-scale-decrease)
(global-set-key (kbd "<C-mouse-7>") 'text-scale-increase)
(define-key global-map (kbd "C-0")
  '(lambda ()
     (interactive)
     (progn (text-scale-mode 0)(buffer-face-mode 0))))

; (global-linum-mode)

(provide '10-views)
;;; 10-views.el ends here
