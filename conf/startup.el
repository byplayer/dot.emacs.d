; ���ݒ�ǂݍ���
(setq load-path
     (cons (expand-file-name "~/.emacs.d/conf/") load-path))
(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/") load-path))

; load OS, emacs version def
(load "init-run-ver")

(load "init-jp")
; (load "init-fonts")
(load "init-color")
;; (load "init-key")
;; (load "init-c-mode")
;; (load "init-ruby")
;; (load "init-yaml")
(load "init-others")
;; (load "init-html")
;; (load "init-config")
;; (load "init-vc")
;; (load "init-abbrev")
;; (load "init-speedbar")
;; (load "init-shell")
;; (load "init-window")
;; (load "init-outline")
;; (load "init-php")

; �Ƃ肠����
; ���Ƃ�Meadow�Ɠ����o����悤�ɏC�����܂�
(cond (window-system
  (setq x-select-enable-clipboard t)
    ))
(load "linux/init-anthy.el")

