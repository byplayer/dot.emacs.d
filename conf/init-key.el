;; 改行でnewline
(global-set-key "\C-m" 'newline-and-indent)

;; homeをVCライクにするための関数
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

;; Ctrl+Zで最小化しない
(define-key global-map "\C-z" 'scroll-down)

;; \C-i - [TAB]を解除
;; 以下を指定するとTABも解除されてしまう・・・
;; 無念
; (global-unset-key "\C-i")

(global-unset-key "\M-`")