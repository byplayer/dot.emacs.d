;;; package --- Summary
;;; Commentary:
;;; Code:
(use-package company-quickhelp
  :ensure t)

(require 'company)
(global-company-mode)
(setq company-idle-delay 0.2)             ;default is 0.5
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

(defun company-mode/backend-with-yas (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; use ascii only for abbrev
(defun edit-category-table-for-company-dabbrev (&optional table)
  (define-category ?s "word constituents for company-dabbrev" table)
  (let ((i 0))
    (while (< i 128)
      (if (equal ?w (char-syntax i))
      (modify-category-entry i ?s table)
    (modify-category-entry i ?s table t))
      (setq i (1+ i)))))
(edit-category-table-for-company-dabbrev)
;; (add-hook 'TeX-mode-hook 'edit-category-table-for-company-dabbrev) ; 下の追記参照
(setq company-dabbrev-char-regexp "\\(\\cs|\\sw\\|\\s_\\|_\\|-\\)")

(provide '00-company)
;;; 00-company.el ends here
