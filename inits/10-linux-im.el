;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package mozc
  :init
  (use-package mozc-popup)
  (setq mozc-candidate-style 'popup)
  (setq mozc-leim-title "[あ]")
  (setq default-input-method "japanese-mozc"))

(provide '10-linux-im)
;;; 10-linux-im.el ends here
