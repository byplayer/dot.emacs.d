; �t�H���g�ݒ�
(w32-add-font
     "MS Mincho 12"
     '((spec
  ((:char-spec ascii :height any)
   strict
   (w32-logfont "MS Mincho" 0 -12 400 0 nil nil nil 0 1 3 0))
  ((:char-spec ascii :height any :weight bold)
   strict
   (w32-logfont "MS Mincho" 0 -12 700 0 nil nil nil 0 1 3 0)
   ((spacing . -1)))
  ((:char-spec ascii :height any :slant italic)
   strict
   (w32-logfont "MS Mincho" 0 -12 400 0   t nil nil 0 1 3 0))
  ((:char-spec ascii :height any :weight bold :slant italic)
   strict
   (w32-logfont "MS Mincho" 0 -12 700 0   t nil nil 0 1 3 0)
   ((spacing . -1)))
  ((:char-spec japanese-jisx0208 :height any)
   strict
   (w32-logfont "MS Mincho" 0 -12 400 0 nil nil nil 128 1 3 0))
  ((:char-spec japanese-jisx0208 :height any :weight bold)
   strict
   (w32-logfont "MS Mincho" 0 -12 700 0 nil nil nil 128 1 3 0)
   ((spacing . -1)))
  ((:char-spec japanese-jisx0208 :height any :slant italic)
   strict
   (w32-logfont "MS Mincho" 0 -12 400 0   t nil nil 128 1 3 0))
  ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
   strict
   (w32-logfont "MS Mincho" 0 -12 700 0   t nil nil 128 1 3 0)
   ((spacing . -1))))))
; �N���������new-frame���̃t���[��(�E�B���h�E)�̐ݒ�B
(add-to-list 'default-frame-alist '(font . "MS Mincho 12"))
; ���݂̃t���[���̐ݒ�(.emacs���ł͏ȗ���)
(set-frame-font "MS Mincho 12")
; IME�̃t�H���g��ݒ�B�������������łȂ��Ƃ��߂炵���B
(let ((logfont '(w32-logfont "MS Mincho" 0 0 400 0 nil nil nil 128 1 3 0)))
  (modify-frame-parameters (selected-frame) (list (cons 'ime-font logfont)))
  (add-to-list 'default-frame-alist (cons 'ime-font logfont))
  )

(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(font . "MS Mincho 12")
                   initial-frame-alist))))