; �I��͈́i���[�W�����j���n�C���C�g
(transient-mark-mode 1)

; �Ή�����o�p���n�C���C�g
(show-paren-mode 1)

;; �V���^�b�N�X�n�C���C�g��L���ɂ���
(global-font-lock-mode t)

;; font-lock�ł̑������x��
(setq font-lock-maximum-decoration t)
(setq fast-lock nil)
(setq lazy-lock nil)
(setq jit-lock t)

; �F�ݒ�
;; region �̐F
(set-face-background 'region "snow3")
(set-face-foreground 'region "black")

(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(foreground-color . "light gray") ;; ��������
                   '(background-color . "black") ;; �w�i�͍�
                   '(border-color     . "black")
                   '(mouse-color      . "light gray")
                   '(cursor-color     . "light gray")
                   ; '(cursor-type      . hairline-caret)
                   '(menu-bar-lines . 1)
                   ; '(font . "MS Mincho 12")
                   ;; ���_�Ȃ� shinonome16-fontset �Ȃǂ��w��
                   ; '(vertical-scroll-bars . nil) ;;�X�N���[���o�[�͂���Ȃ�
                   '(width . 202) ;; �E�B���h�E��
                   '(height . 77) ;; �E�B���h�E�̍���
                   ; '(top . 60) ;;�\���ʒu
                   ; '(left . 140) ;;�\���ʒu
                   '(line-spae 0)
                   )
                  initial-frame-alist)))

;====================================
; �X�N���[���ݒ�
;====================================
(setq scroll-conservatively 35
  scroll-margin 0
  scroll-step 4) ;4�s���X�N���[������

;====================================
; �J�[�\���ړ��ݒ�
;====================================
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/physical-line/") load-path))

;�J�[�\���ړ���_���s�ł͂Ȃ��A�����s�i�����܂܁j�P�ʂňړ�����B
(require 'physical-line)
(setq-default physical-line-mode t)
;; dired-mode �͘_���s�ړ��̂܂܂ɂ���.
(setq physical-line-ignoring-mode-list '(dired-mode))

(set-face-foreground 'font-lock-comment-face "NavajoWhite2")
(set-face-foreground 'font-lock-string-face "tomato2")
(set-face-foreground 'font-lock-keyword-face "DarkSeaGreen3")
(set-face-foreground 'font-lock-constant-face "aquamarine3")
(set-face-foreground 'font-lock-type-face "DarkOliveGreen3")
(set-face-foreground 'font-lock-variable-name-face "burlywood3")

(set-face-foreground 'minibuffer-prompt "LightSkyBlue")

;; �x���n
(require 'flymake)
(set-face-foreground 'flymake-errline "black")
(set-face-foreground 'flymake-warnline "black")

; grep �Ō��������t�@�C�����Ȃ�
(set-face-bold-p 'compilation-info nil)
(set-face-foreground 'compilation-info "DarkOliveGreen3")

; �R���p�C���̌x��
(set-face-bold-p 'compilation-warning nil)
(set-face-foreground 'compilation-warning "NavajoWhite2")

(set-face-bold-p 'font-lock-warning-face nil)
(setq default-frame-alist initial-frame-alist)

;
(set-face-foreground 'escape-glyph "aquamarine3")
(set-face-foreground 'link "LightSkyBlue")

(setq ansi-color-names-vector
      ["black" "dark red" "DarkOliveGreen3" "NavajoWhite2" "LightSkyBlue" "dark magenta"
       "DarkSlateGray2" "white"])

;; �c�[���o�[���B��
(tool-bar-mode nil)


;; �s�ԍ��\��
;; wb-line-number
;; �d���̂ō폜
;; (require 'wb-line-number)

;; (setq truncate-partial-width-windows nil)
;; (set-scroll-bar-mode nil)
;; (setq wb-line-number-scroll-bar t)

;; (wb-line-number-enable)
;; (custom-set-faces
;;  '(wb-line-number-face ((t (:foreground "light gray"))))
;;  '(wb-line-number-scroll-bar-face
;;    ((t (:foreground "black" :background "light gray")))))
;; (global-set-key "\C-x3" 'wb-line-number-split-window-horizontally)