;; set default encoding utf-8-unix
(add-hook 'after-init-hook '(lambda ()
    (setq default-buffer-file-coding-system 'utf-8-unix)
))

;; controll order of auto detect encoding
(prefer-coding-system 'euc-jp-unix)
(prefer-coding-system 'utf-8-unix)

;; support NTEmacs file system encoding
(if (and run-w32 (not run-meadow))
    (progn
      (setq default-file-name-coding-system 'japanese-shift-jis-dos)))