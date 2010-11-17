; ホスト名
(setq hostname (getenv "HOSTNAME"))
(if (null hostname)
    (setq hostname (getenv "HOST")))
(if (null hostname)
    (setq hostname (getenv "COMPUTERNAME")))
(if (null hostname)
    (setq hostname "no_host"))

; 小文字に
(setq hostname (downcase hostname))

; ピリオド以下削除(ピリオドがなければ変更なし)
(setq hostname (car (split-string hostname "\\.")))

; ~/.emacs.ホスト名
(setq hostconf (expand-file-name (concat "~/.emacs.d/conf/hosts/" hostname ".el")))

; ~/.emacs.ホスト名 があれば読み出す
(if (file-exists-p hostconf)
    (load-file hostconf))
