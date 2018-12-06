;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'company)
(global-company-mode)
(setq company-idle-delay 0)             ;default is 0.5
(setq company-minimum-prefix-length 2)  ;default is 4
(setq company-selection-wrap-around t)
(company-quickhelp-mode +1)

(global-set-key (kbd "C-M-i") 'company-complete)

;; C-n, C-p move company candidates
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; search C-s
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TAB
(define-key company-active-map (kbd "<tab>") 'company-complete-selection)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

;; company-mode for all mode C-M-i
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

(add-to-list 'company-backends 'company-yasnippet)

(provide '00-company)
;;; 00-company.el ends here
