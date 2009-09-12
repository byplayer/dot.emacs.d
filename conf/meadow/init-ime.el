																				; 日本語入力
(set-language-environment "Japanese")
(setq default-input-method "MW32-IME")
(mw32-ime-initialize)

(setq mw32-ime-show-mode-line t)				; デフォルトで t(表示する)。

;; モードラインに表示される IME のインジケータをカスタマイズする
																				;  OFF : [--]
																				;  ON  : [あ]
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list
			'("[--]" "[あ]" "[--]"))


