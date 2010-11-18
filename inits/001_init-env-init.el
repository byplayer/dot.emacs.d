(add-to-list 'load-path "~/.emacs.d/inits-env")
(when run-meadow
  (load "meadow/init-fonts")
  (load "meadow/init-ime")
  (load "meadow/init-env"))

(when run-linux
  ; (load "linux/init-anthy")
  (load "linux/init-ibus")
  (load "linux/init-clipboard")
  (load "linux/init-font")
  (load "linux/init-env"))
