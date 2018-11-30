;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'company)
(global-company-mode)
(setq company-idle-delay 0)             ;default is 0.5
(setq company-minimum-prefix-length 2)  ;default is 4
(setq company-selection-wrap-around t)

(provide '00-company)
;;; 00-company.el ends here
