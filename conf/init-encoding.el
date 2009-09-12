; デフォルトエンコードをutf8-unix
(add-hook 'after-init-hook '(lambda ()
    (setq default-buffer-file-coding-system 'utf-8-unix)
))
