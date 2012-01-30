;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; いろいろ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; バックアップファイルなし
(setq make-backup-files nil)

; toolbarなし
(setq tool-bar-mode nil)

;; indent
(setq-default indent-level 2)
;;タブ幅を 2 に設定
(setq-default tab-width 2)

;; use space insted of tab
(setq-default indent-tabs-mode nil)

; カーソル列表示
(column-number-mode 1)

; トップページを非表示に
(setq inhibit-startup-message t)

; 前回編集位置保存
(load "saveplace")
(setq-default save-place t)
(setq-default save-place-limit 50)

; タイトルをファイル名にする
(setq frame-title-format "%b")

; auto scroll on compile buffer
(setq compilation-scroll-output t)

; EOFを表示
(load "y_eof")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 折り返ししない
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

; スクロールは1行単位
(setq scroll-step 1)

; カーソル位置にあわせて左右自動スクロール
(setq auto-show-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; show tab and space
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; show white space of end of line
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
     '(("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; show white space
(require 'whitespace)
(setq whitespace-style
      '(face tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(global-whitespace-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; バージョン管理下のバックアップファイルを作らない
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq vc-make-backup-files nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; バッチ、iniなどのモード追加
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'generic-x)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacsclient server
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(server-start)

;; undo-tree
;; (install-elisp "http://dr-qubit.org/undo-tree/undo-tree.el")
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; point-undo
;; (install-elisp "http://emacswiki.org/cgi-bin/wiki/download/point-undo.el")
;; (when (require 'point-undo nil t)
;;   (define-key global-map [f7] 'point-undo)
;;   (define-key global-map [S-f7] 'point-redo))
;; doesn't work my environtment ...