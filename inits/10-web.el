;;; package --- Summary
;;; Commentary:
;;; Code:

(leaf rainbow-mode
  :ensure t)

(leaf scss-mode
  :ensure t
  :mode (("\\.scss" . scss-mode)))

(leaf web-mode
  :ensure t
  :mode (("\\.css" . css-mode)
         ("\\.html$"     . web-mode)
         ("\\.tpl$"     . web-mode)
         ("\\.rxml$" . web-mode)
         ("\\.erb$". web-mode)
         ("\\.rhtml$". web-mode))
  :hook ((web-mode-hook . my/web-mode-hook))
  :init
  (defun my/web-mode-hook ()
    (setq web-mode-markup-indent-offset 2) ;; html indent
    (setq web-mode-css-indent-offset 2)    ;; css indent
    (setq web-mode-code-indent-offset 2))  ;; script indent(js,php,etc..)

  ;; 色の設定
  (custom-set-faces
   '(web-mode-doctype-face
     ((t (:foreground "#82AE46"))))                          ; doctype
   '(web-mode-html-tag-face
     ((t (:foreground "#E6B422" :weight bold))))             ; 要素名
   '(web-mode-html-attr-name-face
     ((t (:foreground "#C97586"))))                          ; 属性名など
   '(web-mode-html-attr-value-face
     ((t (:foreground "#82AE46"))))                          ; 属性値
   '(web-mode-comment-face
     ((t (:foreground "#D9333F"))))                          ; コメント
   '(web-mode-server-comment-face
     ((t (:foreground "#D9333F"))))                          ; コメント
   '(web-mode-css-rule-face
     ((t (:foreground "#A0D8EF"))))                          ; cssのタグ
   '(web-mode-css-pseudo-class-face
     ((t (:foreground "#FF7F00"))))                          ; css 疑似クラス
   '(web-mode-css-at-rule-face
     ((t (:foreground "#FF7F00"))))                          ; cssのタグ
   )

  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'scss-mode-hook 'rainbow-mode)

  (setq css-indent-offset 2)
  (setq cssm-indent-level 2)
  (setq cssm-indent-function #'cssm-c-style-indenter))


(leaf js2-mode
  :ensure t
  :mode (("\\.js$" . js2-mode))
  :init
  (add-hook 'js2-mode-hook
          '(lambda ()
             (require 'js)
             (setq js2-basic-offset 2
                   indent-tabs-mode nil
                   js2-cleanup-whitespace nil
                   js2-bounce-indent-flag nil)
             (flyspell-prog-mode)
             (define-key js2-mode-map "\C-m" 'newline-and-indent)
             (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)))
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))
  )

(leaf json-mode
  :ensure t
  :mode (("\.json" . json-mode)))

;;; 10-html.el ends here
