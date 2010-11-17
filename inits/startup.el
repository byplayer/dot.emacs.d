
; ŠÂ‹«İ’è“Ç‚İ‚İ
(setq load-path
     (cons (expand-file-name "~/.emacs.d/inits/") load-path))
(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/") load-path))

; load OS, emacs version def
(load "init-run-ver")

(when run-meadow
  (load "meadow/init-fonts")
  (load "meadow/init-ime")
  (load "meadow/init-env")
  )

(when run-linux
  ; (load "linux/init-anthy")
  (load "linux/init-ibus")
  (load "linux/init-clipboard")
  (load "linux/init-font")
  (load "linux/init-env")
)

(load "init-auto-install")
(load "init-anything")
(load "init-encoding")
(load "init-views")
(load "init-key")
(load "init-c-mode")
(load "init-ruby")
(load "init-yaml")
(load "init-others")
(load "init-html")
(load "init-config")
(load "init-abbrev")
(load "init-window")
(load "init-outline")
(load "init-php")
(load "init-git")
(load "init-hostconf")
(load "init-markdown")
(load "init-recentfile")
(load "init-utils")
(load "init-register")
(load "init-remember")
(load "init-diff")
(load "init-dired")
(load "init-term")