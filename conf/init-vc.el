; 環境設定読み込み
(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/vc/") load-path))


(require 'psvn)
;; psvn向け設定
;; 未知のファイルも表示
(setq svn-status-hide-unknown nil)
(setq svn-status-hide-unmodified nil)
(set-face-bold-p 'svn-status-locked-face nil)
(set-face-foreground 'svn-status-locked-face "tomato2")

;; キーカスタマイズ
;; (defun svn-lock-file-private(arg)
;;   (svn-run t t 'lock "lock" "--targets" arg))
;; (global-set-key "\C-c\C-vk" 'svn-lock-file('hoge'))