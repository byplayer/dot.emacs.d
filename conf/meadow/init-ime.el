																				; ���{�����
(set-language-environment "Japanese")
(setq default-input-method "MW32-IME")
(mw32-ime-initialize)

(setq mw32-ime-show-mode-line t)				; �f�t�H���g�� t(�\������)�B

;; ���[�h���C���ɕ\������� IME �̃C���W�P�[�^���J�X�^�}�C�Y����
																				;  OFF : [--]
																				;  ON  : [��]
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list
			'("[--]" "[��]" "[--]"))


