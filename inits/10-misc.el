;;; package --- Summary
;;; Commentary:
;;; Code:






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
    undo-tree-visualizer-mode
    lookup-content-mode
    calendar-mode
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

(defun kill-all-buffers()
  "The kill-all-buffers kill all buffers."
  (interactive)
  (yes-or-no-p "kill all buffer? ")
  (wipe))

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
  (insert (format-time-string "%Y%m%d %A")))

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
      (cons ' ( "\\.txt\\'" . org-mode) auto-mode-alist))

;; delete-trailing-whitespace
(setq delete-trailing-whitespace-modes '(rst-mode text-mode org-mode outline-mode))
(defun delete-trailing-whitespace-before-save()
  (if (member major-mode delete-trailing-whitespace-modes) (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'delete-trailing-whitespace-before-save)

;; prettier
(setq prettier-js-mode-hooks
      '(css-mode-hook
        yaml-mode-hook
        markdown-mode-hook
        php-mode-hook
        js2-mode-hook))
(loop for hook in prettier-js-mode-hooks
      do (add-hook hook 'prettier-js-mode))

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
    (text-mode . "Tx")
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

(defun sphinx-compile ()
  "Traveling up the path, find build.xml file and run compile."
  (interactive)
  (save-buffer)
  (with-temp-buffer
    (while (and (not (or (file-exists-p "makefile")
                         (file-exists-p "Makefile")))
                (not (equal "/" default-directory)))
      (cd ".."))
    (call-interactively 'compile)))

(add-hook 'rst-mode-hook
          '(lambda()
             (define-key rst-mode-map "\C-cc" 'sphinx-compile)
             (define-key rst-mode-map (kbd "<M-return>") 'org-meta-return)
             (define-key rst-mode-map "\C-cn" 'rst-forward-section)
             (define-key rst-mode-map "\C-cp" 'rst-backward-section)))

(defun mkdocs-compile ()
  "Traveling up the path, find build.xml file and run compile."
  (interactive)
  (save-buffer)
  (with-temp-buffer
    (while (and (not (file-exists-p "mkdocs.yml"))
                (not (equal "/" default-directory)))
      (cd ".."))
    (call-interactively 'compile)))

(add-hook 'markdown-mode-hook
          '(lambda()
             (define-key markdown-mode-map "\C-cc" 'mkdocs-compile)
             (define-key markdown-mode-map (kbd "<M-return>") 'org-meta-return)))

;; Show time on mode-line
(setq display-time-interval 1)
(setq display-time-string-forms
  '((format "%s:%s" 24-hours minutes seconds)))
(setq display-time-day-and-date t)
(display-time-mode t)

(provide '10-misc)
;;; 10-misc.el ends here
