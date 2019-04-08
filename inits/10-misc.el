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
(global-set-key (kbd "C-<") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; avy
(global-set-key (kbd "C-c j") 'avy-goto-word-1)

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

;; point-undo
(require 'point-undo)
(global-set-key (kbd "M-[") 'point-undo)
(global-set-key (kbd "M-]") 'point-redo)

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

;; hungry delete
(setq c-hungry-delete-key t)

;; show column
(column-number-mode 1)

;; no show start page
(setq inhibit-startup-message t)

;;; winner-mode
(when (fboundp 'winner-mode)
  (winner-mode t))

;; move window using meta
(windmove-default-keybindings 'meta)

;; use C-x and arrow keys to move focus
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <up>") 'windmove-up)

;; save edit place
(require 'saveplace)
(setq-default save-place t)
(setq-default save-place-limit 1000)

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
(eval-after-load "undo-tree"
  '(progn
     (global-undo-tree-mode)
     (setq undo-tree-auto-save-history t
           undo-tree-history-directory-alist `(("." .,
                                                (expand-file-name "~/.emacs.d/undo-tree-hist/"))))
     (defadvice undo-tree-make-history-save-file-name
       (after undo-tree activate)
       (setq ad-return-value (concat ad-return-value ".gz")))))
(require 'undo-tree)

;; backup directory configuration
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))

(setq version-control t)     ; version control for backup
(setq kept-new-versions 10)   ; keep 10 new files
(setq kept-old-versions 10)   ; keep 10 old files
(setq delete-old-versions t) ; delete old files without confirmation
(setq vc-make-backup-files t) ; backup under version control

;; disable lock file
(setq create-lockfiles nil)

(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/auto-save-list/") t)))

(global-anzu-mode +1)

(require 'savekill)
(setq savekill-max-saved-items 1000)

(defun kill-all-buffer()
  (interactive)
  (yes-or-no-p "kill all buffer? ")
  (dolist (buf (buffer-list))
    (kill-buffer buf)))

(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

(setq flyspell-default-dictionary "english")
(setq ispell-dictionary "english")
(setq ispell-personal-dictionary "~/.emacs.d/.aspell.en.pws")

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(require 'smartparens-config)
(smartparens-global-mode t)

(require 'volatile-highlights)
(volatile-highlights-mode t)

;; dired
(require 'dired-x)
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-isearch-filenames t)

;; neo tree
;; download fonts if necessary
(unless (file-exists-p (concat (getenv "HOME") "/.local/share/fonts/all-the-icons.ttf"))
        (all-the-icons-install-fonts "yes")
        )

(require 'all-the-icons)
(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; show hidden file default
; (setq neo-show-hidden-files t)

;; open new file when create new file on new tree
(setq neo-create-file-auto-open t)

;; don't delete neotree on delete-other-window
(setq neo-persist-show t)

;; show current file directory when I show neo tree
(setq neo-smart-open t)

;; maybe it doesn't work
;; https://github.com/jaypei/emacs-neotree/issues/105
(setq neo-vc-integration '(face char))

;; work with popwin
(when neo-persist-show
  (add-hook 'popwin:before-popup-hook
            (lambda () (setq neo-persist-show nil)))
  (add-hook 'popwin:after-popup-hook
            (lambda () (setq neo-persist-show t))))

(global-set-key [f8] 'neotree-toggle)

;; imenu-list
(global-set-key (kbd "C-]") #'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-size 0.15)

;; for dired with the all icons
(require 'font-lock+)
(require 'dired-x)
(add-hook 'dired-mode-hook
          '(lambda()
             (all-the-icons-dired-mode)
             (dired-omit-mode t)))
(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\..*$")

(defun insert-ymd ()
  "Insert string for today's date(YYYYMMDD).
e.g. 20190401."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%Y%m%d")))
;; keyfreq
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(provide '10-misc)
;;; 10-misc.el ends here
