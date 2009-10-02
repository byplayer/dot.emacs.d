;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ���낢��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �o�b�N�A�b�v�t�@�C���Ȃ�
(setq make-backup-files nil)

; toolbar�Ȃ�
(setq tool-bar-mode nil)

;; indent
(setq-default indent-level 2)
;;�^�u���� 2 �ɐݒ�
(setq-default tab-width 2)

; �J�[�\����\��
(column-number-mode 1)

; �g�b�v�y�[�W���\����
(setq inhibit-startup-message t)

; �O��ҏW�ʒu�ۑ�
(load "saveplace")
(setq-default save-place t)

;; grep�p�̐ݒ�
;; JVim��grep�p�ł�
(setq find-grep-options "-s -q -K SSE ")
(setq grep-command "grep -n -K SSE -e ")

; �^�C�g�����t�@�C�����ɂ���
(setq frame-title-format "%b")

; EOF��\��
(load "y_eof")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �܂�Ԃ����Ȃ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

; �X�N���[����1�s�P��
(setq scroll-step 1)

; �J�[�\���ʒu�ɂ��킹�č��E�����X�N���[��
(setq auto-show-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �X�y�[�X�A�^�u�̎���
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(defface my-face-r-1 '((t (:background "gray15"))) nil)
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;(defvar my-face-r-1 'my-face-r-1)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("�@" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     ;;("[\r]*\n" 0 my-face-r-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �o�[�W�����Ǘ����̃o�b�N�A�b�v�t�@�C�������Ȃ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq vc-make-backup-files t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �o�b�`�Aini�Ȃǂ̃��[�h�ǉ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'generic-x)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacsclient server
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(server-start)