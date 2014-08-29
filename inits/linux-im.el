;;; package --- Summary
;;; Commentary:
;;; Code:

(setq mozc-leim-title "[あ]")
(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'overlay))

;;; linux-im.el ends here
