;; ���ݒ�ǂݍ���
(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/window/") load-path))

;; windows.el�����̐ݒ�
;; �L�[�o�C���h��ύX�D
;; �f�t�H���g�� C-c C-w
;; �ύX���Ȃ��ꍇ�v�́C�ȉ��� 3 �s���폜����
(require 'windows)

;; �V�K�Ƀt���[�������Ȃ�
(setq win:use-frame nil)

(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)

;; �ۑ������Ȃ��o�b�t�@�ݒ�
(setq revive:ignore-buffer-pattern "^ \\*")

;; ������ Undo Redo
(require 'winhist)
(winhist-mode 1)

(global-set-key "\M-B" 'winhist-backward)
(global-set-key "\M-F" 'winhist-forward)