;; ���s��newline
(global-set-key "\C-m" 'newline-and-indent)

;; home��VC���C�N�ɂ��邽�߂̊֐�
(defun vc-like-home()
  (interactive)
  (setq old_pos (point))
  (move-beginning-of-line 1)
  (back-to-indentation)
  (setq new_pos (point))
  (if (= old_pos new_pos)
      (move-beginning-of-line 1)))

(global-set-key [home] 'vc-like-home)
(global-set-key "\C-a" 'vc-like-home)

;; Ctrl+Z�ōŏ������Ȃ�
(define-key global-map "\C-z" 'scroll-down)

;; \C-i - [TAB]������
;; �ȉ����w�肷���TAB����������Ă��܂��E�E�E
;; ���O
; (global-unset-key "\C-i")

(global-unset-key "\M-`")