;;; package --- Summary
;;; Commentary:
;;; Code:

;; migemo
(require 'migemo nil t)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
; (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
;; Mac
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-coding-system 'utf-8-unix)
(migemo-init)

(provide '11-migemo)
;;; 11-migemo.el ends here
