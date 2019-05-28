;;; package --- Summary
;;; Commentary:
;;; Code:

;; start server
(server-start)

;; revive
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)

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

;; auto scroll on compile buffer
(setq compilation-scroll-output 'first-error)

;; show EOF
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

(custom-set-variables
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

;; scroll step
(setq scroll-step 1)

;; show white space of end of line
(setq-default show-trailing-whitespace t)

(defun my/disable-trailing-mode-hook ()
  "Disable show tail whitespace."
  (setq show-trailing-whitespace nil))

(defvar my/disable-trailing-modes
  '(comint-mode
    eshell-mode
    eww-mode
    term-mode
    compilation-mode
    fundamental-mode
    ))

(mapc
 (lambda (mode)
   (add-hook (intern (concat (symbol-name mode) "-hook"))
             'my/disable-trailing-mode-hook))
 my/disable-trailing-modes)

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

(defun insert-ymdhms ()
  "Insert string for today's date(YYYY-mm-dd HH:MM:SS).
e.g. 20190-4-01 15:02:33"
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

;; keyfreq
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(setq auto-mode-alist
      (cons ' ( "\\.txt\\'" . outline-mode) auto-mode-alist))

;; delete-trailing-whitespace
(setq delete-trailing-whitespace-modes '(text-mode org-mode outline-mode))
(defun delete-trailing-whitespace-before-save()
  (if (member major-mode delete-trailing-whitespace-modes) (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'delete-trailing-whitespace-before-save)

;; prettier
(setq prettier-js-mode-hooks
      '(css-mode-hook
        yaml-mode-hook
        markdown-mode-hook
        php-mode-hook))
(loop for hook in prettier-js-mode-hooks
      do (add-hook hook 'prettier-js-mode))

;; clang-format
(use-package clang-format
  :ensure t
  :commands (clang-format-buffer)
  :init
  (setq clang-format-modes
        '(c++-mode c-mode java-mode js2-mode))
  (setq clang-format-style "google")
  (defun my-clang-format-before-save ()
    "Usage: (add-hook 'before-save-hook 'my-clang-format-before-save)"
    (interactive)
    (if (member major-mode clang-format-modes)
        (clang-format-buffer)))

  (add-hook 'before-save-hook #'my-clang-format-before-save)

  :config
  )

(use-package switch-window
  :ensure t
  :commands (switch-window)
  :bind (("C-x o" . switch-window))
  :init
  (setq switch-window-shortcut-style 'qwerty))

;; mode-line
(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " Ys")
    (auto-revert-mode . "")
    (paredit-mode . " Pe")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . " Ut")
    (elisp-slime-nav-mode . " EN")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    (flycheck-mode . " Fc")
    (flyspell-mode . " Fs")
    (anzu-mode . " Az")
    (git-gutter-mode . "")
    (helm-mode . " He")
    (company-mode . " Cp")
    (gtags-mode . " Gt")
    (volatile-highlights-mode . "")
    (ruby-block-mode . " Rb")
    ;; Major modes
    (lisp-interaction-mode . "Li")
    (python-mode . "Py")
    (ruby-mode   . "Rb")
    (emacs-lisp-mode . "El")
    (markdown-mode . "Md")
    (org-mode . "Or")
    (org-agenda-mode . "Oa")
    (help-mode . "He")
    (magit-status-mode . "Ms")
    (compilation-mode . "Cp")
    (fundamental-mode . "Fm")
    ))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(defvar my/vc-mode-line
  '(:propertize
    (:eval (let* ((backend (symbol-name (vc-backend (buffer-file-name))))
                  (branch (substring-no-properties vc-mode (+ (length backend) 2)))
                  (state (if (bound-and-true-p git-gutter-mode)
                             (cl-case (vc-state (buffer-file-name))
                               (edited
                                (format ":%d" (git-gutter:buffer-hunks)))
                               (otherwise ""))
                           "")))
             (concat "(" branch state ")"))))
  "Mode line format for VC Mode.")
(put 'my/vc-mode-line 'risky-local-variable t)

(setq-default mode-line-format
                '("%e"
                  mode-line-front-space
                  mode-line-mule-info
                  mode-line-client
                  mode-line-modified
                  mode-line-remote
                  mode-line-frame-identification
                  mode-line-buffer-identification " " mode-line-position
                  (vc-mode my/vc-mode-line)
                  " "
                  mode-line-modes mode-line-misc-info mode-line-end-spaces))

;; hs-minor-mode
(use-package hideshow
  :ensure t
  :commands (hs-minor-mode)
  :bind (("C-#" . hs-toggle-hiding)
         ("C-+" . hs-show-all)
         ("C-=" . hs-hide-all))
  :init
  ;; Set up hs-mode (HideShow) for Ruby
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do")) ; Block start
                 ,(rx (or "end"))                       ; Block end
                 ,(rx (or "#" "=begin"))                ; Comment start
                 ruby-forward-sexp nil))
  (defun my/add-hs-minor-mode()
    (hs-minor-mode 1))
  (add-hook 'prog-mode-hook 'my/add-hs-minor-mode))

;; lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda()
             (progn
               (setq indent-tabs-mode nil)
               (flyspell-prog-mode))))

(add-hook 'lisp-mode-hook
          '(lambda()
             (progn
               (setq indent-tabs-mode nil)
               (flyspell-prog-mode))))

(provide '10-misc)
;;; 10-misc.el ends here
