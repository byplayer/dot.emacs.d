;; �ۑ�����w�肷��
(setq abbrev-file-name "~/.abbrev_defs")
;; ���̓W�J�̃L�[�o�C���h���w�肷��
(define-key esc-map  " " 'expand-abbrev) ;; M-SPC
;; �N�����ɕۑ��������̂�ǂݍ���
(quietly-read-abbrev-file)
;; ���̂�ۑ�����
(setq save-abbrevs t)

;; �����W�J�����Ȃ�
(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))
