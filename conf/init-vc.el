; ���ݒ�ǂݍ���
(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/vc/") load-path))


(require 'psvn)
;; psvn�����ݒ�
;; ���m�̃t�@�C�����\��
(setq svn-status-hide-unknown nil)
(setq svn-status-hide-unmodified nil)
(set-face-bold-p 'svn-status-locked-face nil)
(set-face-foreground 'svn-status-locked-face "tomato2")

;; �L�[�J�X�^�}�C�Y
;; (defun svn-lock-file-private(arg)
;;   (svn-run t t 'lock "lock" "--targets" arg))
;; (global-set-key "\C-c\C-vk" 'svn-lock-file('hoge'))