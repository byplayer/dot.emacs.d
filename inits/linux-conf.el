;;; package --- Summary
;;; Commentary:
;;; Code:

(set-face-attribute 'default nil :family "Source Han Code JP M" :height 160)
(set-frame-font "Source Han Code JP M")

(cond (window-system
  (setq select-enable-clipboard t)
  ))

(use-package mozc
  :init
  (use-package mozc-popup)
  (setq mozc-candidate-style 'popup)
  (setq mozc-leim-title "[あ]")
  (setq default-input-method "japanese-mozc"))

;;; linux-conf.el ends here
