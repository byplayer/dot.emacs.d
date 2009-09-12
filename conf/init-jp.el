;;; Mule-UCS �̐ݒ�
; (require 'un-define) ; Unicode
; (require 'jisx0213)  ; JIS X 0213

(when run-meadow
  ; ���{�����
  (set-language-environment "Japanese")
  (setq default-input-method "MW32-IME")
  (mw32-ime-initialize)

  (setq mw32-ime-show-mode-line t) ; �f�t�H���g�� t(�\������)�B

  ;; ���[�h���C���ɕ\������� IME �̃C���W�P�[�^���J�X�^�}�C�Y����
  ;  OFF : [--]
  ;  ON  : [��]
  (setq-default mw32-ime-mode-line-state-indicator "[--]")
  (setq mw32-ime-mode-line-state-indicator "[--]")
  (setq mw32-ime-mode-line-state-indicator-list
	'("[--]" "[��]" "[--]")))

; �f�t�H���g�G���R�[�h��utf8-unix
(add-hook 'after-init-hook '(lambda ()
    (setq default-buffer-file-coding-system 'utf-8-unix)
))
