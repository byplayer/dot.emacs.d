;;; package --- Summary
;;; Commentary:
;;; Code:

;; start server
(server-start)

(require 'desktop)
(setq desktop-globals-to-save '(extended-command-history))
(setq desktop-files-not-to-save "")
(desktop-save-mode t)

;; regin
(require 'expand-region)
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; select
(require 'multiple-cursors)
(require 'smartrep)
(declare-function smartrep-define-key "smartrep")

(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C-M-r") 'mc/mark-all-in-region)

(global-unset-key "\C-t")

(smartrep-define-key global-map "C-t"
  '(("C-t"      . 'mc/mark-next-like-this)
    ("n"        . 'mc/mark-next-like-this)
    ("p"        . 'mc/mark-previous-like-this)
    ("m"        . 'mc/mark-more-like-this-extended)
    ("u"        . 'mc/unmark-next-like-this)
    ("U"        . 'mc/unmark-previous-like-this)
    ("s"        . 'mc/skip-to-next-like-this)
    ("S"        . 'mc/skip-to-previous-like-this)
    ("*"        . 'mc/mark-all-like-this)
    ("d"        . 'mc/mark-all-like-this-dwim)
    ("i"        . 'mc/insert-numbers)
    ("o"        . 'mc/sort-regions)
    ("O"        . 'mc/reverse-regions)))

;; undohist
(require 'undohist)
(undohist-initialize)

;; point-undo
(require 'point-undo)
(global-set-key (kbd "M-[") 'point-undo)
(global-set-key (kbd "M-]") 'point-redo)

;; no backup file
(setq make-backup-files nil)
;; no backup under vc-mode
(setq vc-make-backup-files nil)

;; support bat moad, ini mode
(require 'generic-x)

;; no toolbar
(tool-bar-mode 0)

;; indent
(setq-default indent-level 2)
;; default tab witdh
(setq-default tab-width 2)
;; use space insted of tab
(setq-default indent-tabs-mode nil)

;; show column
(column-number-mode 1)

;; no show start page
(setq inhibit-startup-message t)

;;; winner-mode
(when (fboundp 'winner-mode)
  (winner-mode t))

;; move window using meta
(windmove-default-keybindings 'meta)

;; save edit place
(require 'saveplace)
(setq-default save-place t)
(setq-default save-place-limit 100)

;; show buffer name to title
(setq frame-title-format "%b")

; auto scroll on compile buffer
(eval-after-load "compilation-mode"
  '(progn
     (setq compilation-scroll-output t)))

;; show EOF
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

(custom-set-variables
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

;; scroll step
(setq scroll-step 1)

;; show white space of end of line
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil
  :group 'font-lock-highlighting-faces)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  "Set font lock mode."
  (font-lock-add-keywords
   major-mode
     '(("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; show white space
(require 'whitespace)
(setq whitespace-style
      '(face tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(global-whitespace-mode 1)


;; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

(provide '10-misc)
;;; 10-misc.el ends here
