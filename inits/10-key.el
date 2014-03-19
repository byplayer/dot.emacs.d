;;; Code:
;; Enter as newline
(global-set-key "\C-m" 'newline-and-indent)

;; home as Visual C like
(defun vc-like-home()
  (interactive)
  (let
      ((old_pos 0)
       (new_pos 0))
  (setq old_pos (point))
  (move-beginning-of-line 1)
  (back-to-indentation)
  (setq new_pos (point))
  (if (= old_pos new_pos)
      (move-beginning-of-line 1))))

(global-set-key [home] 'vc-like-home)
(global-set-key "\C-a" 'vc-like-home)

;; don't minimize Ctrl+Z
(define-key global-map "\C-z" 'scroll-down)

(global-unset-key "\M-`")
