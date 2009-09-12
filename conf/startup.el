
; ŠÂ‹«İ’è“Ç‚İ‚İ
(setq load-path
     (cons (expand-file-name "~/.emacs.d/conf/") load-path))
(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/") load-path))

; load OS, emacs version def
(load "init-run-ver")

(when run-meadow
  (load "meadow/init-fonts")
  (load "meadow/init-ime")
  )

(when run-linux
  (load "linux/init-anthy")
  (load "linux/init-clipboard")
)

(load "init-encoding")
(load "init-color")
(load "init-key")
(load "init-c-mode")
(load "init-ruby")
(load "init-yaml")
(load "init-others")
(load "init-html")
(load "init-config")
(load "init-vc")
(load "init-abbrev")
(load "init-speedbar")
(load "init-shell")
(load "init-window")
(load "init-outline")
(load "init-php")





