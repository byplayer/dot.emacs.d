;;; package --- Summary
;;; Commentary:
;;; Code:

(set-face-attribute 'default nil :family "Source Han Code JP M" :height 80)
(set-frame-font "Source Han Code JP M")

(cond (window-system
  (setq select-enable-clipboard t)
  ))

(leaf mozc
  :init
  (setq mozc-leim-title "[あ]")
  (setq default-input-method "japanese-mozc"))

;;; linux-conf.el ends here
