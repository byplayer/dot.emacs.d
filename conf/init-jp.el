;;; Mule-UCS の設定
; (require 'un-define) ; Unicode
; (require 'jisx0213)  ; JIS X 0213

(when run-meadow
  ; 日本語入力
  (set-language-environment "Japanese")
  (setq default-input-method "MW32-IME")
  (mw32-ime-initialize)

  (setq mw32-ime-show-mode-line t) ; デフォルトで t(表示する)。

  ;; モードラインに表示される IME のインジケータをカスタマイズする
  ;  OFF : [--]
  ;  ON  : [あ]
  (setq-default mw32-ime-mode-line-state-indicator "[--]")
  (setq mw32-ime-mode-line-state-indicator "[--]")
  (setq mw32-ime-mode-line-state-indicator-list
	'("[--]" "[あ]" "[--]")))

; デフォルトエンコードをutf8-unix
(add-hook 'after-init-hook '(lambda ()
    (setq default-buffer-file-coding-system 'utf-8-unix)
))
