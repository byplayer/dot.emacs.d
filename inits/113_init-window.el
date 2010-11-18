;; 環境設定読み込み
(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/window/") load-path))

;; windows.el向けの設定
;; キーバインドを変更．
;; デフォルトは C-c C-w
;; 変更しない場合」は，以下の 3 行を削除する
(require 'windows)

;; 新規にフレームを作らない
(setq win:use-frame nil)

(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)

;; 保存時しないバッファ設定
(setq revive:ignore-buffer-pattern "^ \\*")

;; 分割の Undo Redo
(require 'winhist)
(winhist-mode 1)

(global-set-key "\M-B" 'winhist-backward)
(global-set-key "\M-F" 'winhist-forward)