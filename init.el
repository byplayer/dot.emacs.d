;;; package --- Summary
;;; Commentary:
;;; Author: byplayer
;;; Code:

;; reduce gc for loading init
(setq gc-cons-threshold most-positive-fixnum)

(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    ; (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    ; (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf dash
  :ensure t)

(leaf f
  :ensure t)

(leaf lv
  :ensure t)

(leaf lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((go-mode-hook . lsp-deferred)
         (lsp-mode-hook . (lambda()
              (local-set-key (kbd "M-*") 'xref-pop-marker-stack)
              (local-set-key (kbd "M-.") 'xref-find-definitions)
              (local-set-key (kbd "M-/") 'xref-find-references)))))

(leaf lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode)

(leaf company-quickhelp
  :doc help support for company
  :ensure t)

(leaf company
  :ensure t
  :commands global-company-mode
  :bind (("C-M-i" . company-complete))
  :bind (company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("<tab>" . company-complete-selection)
         ("C-i" . company-complete-selection)
         ("C-s" . company-filter-candidates))
  :bind (emacs-lisp-mode-map
         ("C-M-i" . company-complete))
  :defvar (company-idle-delay
           company-minimum-prefix-length
           company-selection-wrap-around
           company-backends
           company-dabbrev-char-regexp)
  :defun (company-mode/backend-with-yas
          edit-category-table-for-company-dabbrev)
  :init
  (global-company-mode)
  (setq company-idle-delay 0.5)             ;default is 0.5
  (setq company-minimum-prefix-length 2)  ;default is 4
  (setq company-selection-wrap-around t)
  (company-quickhelp-mode +1)
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
  (setq company-dabbrev-char-regexp "\\(\\cs\\|_\\|-\\)"))

(leaf company-lsp
  :ensure t
  :after company
  :commands company-lsp)

(leaf *encoding
  :defvar default-buffer-file-coding-system
  :hook (after-init-hook . (lambda ()
                             (setq default-buffer-file-coding-system 'utf-8-unix)))
  :init
  (prefer-coding-system 'euc-jp-unix)
  (prefer-coding-system 'utf-8-unix))

(leaf popwin
  :commands popwin-mode
  :bind ("C-x p" . popwin:display-last-buffer)
  :defvar (popwin:special-display-config)
  :init
  (popwin-mode 1)
  (setq popwin:special-display-config '(; ("*compilation*" :noselect t)
                                      ("*compilation*")
                                      ("*rspec-compilation*" :regexp t)
                                      ; ("^\*helm.+\*$" :regexp t :height 0.4)
                                      ; ("*my helm*" :regexp t :height 0.4)
                                      )))

(leaf *server
  :doc start server for emacs client
  :hook (window-setup-hook . server-start))

(leaf expand-region
  :doc expand region
  :ensure t
  :bind (("C-<" . er/expand-region)
         ("C-M-," . er/contract-region)))

(leaf avy
  :doc quick search
  :ensure t
  :bind (("C-c j" . avy-goto-word-1)))

(leaf winner
  :init
  (winner-mode))

(leaf *config-for-c
  :doc configuration for c/c++
  :hook (c-mode-common-hook . my/c-mode-hook)
  :init
  (leaf irony
    :doc C/C++ suggestion tool
    :ensure t
    :require t
    :defvar (flycheck-clang-language-standard c-basic-offset irony-supported-major-modes)
    :hook (irony-mode-hook . (lambda()
                               (irony-cdb-autosetup-compile-options)
                               (add-to-list
                                (make-local-variable 'company-backends)
                                '(company-irony :with company-yasnippet))))
    :setq (flycheck-clang-language-standard . "c++14"))

  (defun my/c-mode-hook ()
    (c-set-offset 'statement-block-intro 2)
    (setq c-basic-offset 2)
    (turn-on-font-lock)
    (local-set-key "\C-cc" 'compile)
    (when (member major-mode irony-supported-major-modes)
      (irony-mode 1))))

(leaf gitignore-mode
  :ensure t)

(leaf git-gutter
  :ensure t
  :init
  (global-git-gutter-mode t))

(leaf magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :bind (magit-mode-map
         ("c" . magit-commit-create)
         ("M-c" . magit-commit)
         ("P" . magit-push-current-to-upstream)
         ("M-P" . magit-push)
         ("F" . magit-pull-from-upstream)
         ("M-F" . magit-pull)))

(leaf go-mode
  :doc for go lang development
  :ensure t
  :after company
  :mode (("\.go$" . go-mode))
  :defvar (indent-level)
  :hook ((go-mode-hook . (lambda()
                           (go-eldoc-setup)
                           (company-mode)
                           (flycheck-mode)
                           (setq indent-level 4)
                           (setq c-basic-offset 4)
                           (setq tab-width 4)
                           (define-key go-mode-map (kbd "C-c c") 'go-compile)
                           (add-to-list
                            (make-local-variable 'company-backends)
                            '(company-go :with company-yasnippet))))
         (go-mode-hook . lsp-go-install-save-hooks))
  :bind (go-mode-map
         ("C-c d" . helm-godoc))
  :config
  (leaf helm-godoc
    :el-get syohex/emacs-helm-godoc
    :commands helm-godoc)

  (leaf helm-go-package
    :ensure t
    :commands helm-go-package
    :defer-config (go-mode (substitute-key-definition
                            'go-import-add 'helm-go-package go-mode-map)))
  :defun (lsp-format-buffer lsp-organize-imports)

  :init
  (defun go-compile ()
    "Traveling up the path, find build.xml file and run compile."
    (interactive)
    (save-buffer)
    (with-temp-buffer
      (while (and (not (or (file-exists-p "go.mod")
                           (file-directory-p ".git")))
                  (not (equal "/" default-directory)))
        (cd ".."))
      (call-interactively 'compile)))

  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t)))

(leaf *sh-mode-config
  :doc sh-mode configuration
  :defvar (sh-basic-offset
           sh-indent-after-continuation
           sh-indent-for-continuation)
  :hook ((sh-mode-hook . (lambda ()
                           (setq sh-basic-offset 2
                                 sh-indent-after-continuation nil
                                 sh-indent-for-continuation 0)))))

(leaf python
  :ensure t
  :mode (("\\.py$" . python-mode)))

(leaf pyenv
  :el-get aiguofer/pyenv.el
  :commands global-pyenv-mode
  :init
  (global-pyenv-mode))

(leaf py-autopep8
  :ensure t
  :commands (py-autopep8-before-save py-autopep8-enable-on-save)
  :hook (python-mode-hook . py-autopep8-enable-on-save))

(leaf elpy
  :ensure t
  :init
  (elpy-enable))

(leaf php-mode
  :ensure t
  :mode (("\\.php$" . php-mode)
         ("\\.inc$" . php-mode))
  :bind (php-mode-map
         ("C-M-i" . company-complete)
         ("C-c , s" . phpunit-current-test)
         ("C-c , v" . phpunit-current-class)
         ("C-c , a" . phpunit-current-project))
  :defun (php-set-style)
  :hook (php-mode-hook . (lambda()
             (php-set-style "php")
             (setq c-basic-offset 4)
             (setq tab-width 4)
             (setq indent-tabs-mode nil))))

(leaf :java
  :doc
  configuration for java
  :defvar (java-mode-map)
  :hook ((java-mode-hook . (lambda ()
                             (setq c-basic-offset 2)
                             (setq tab-width 2)
                             (setq indent-tabs-mode nil)
                             (define-key java-mode-map (kbd "C-c c") 'java-compile))))
  :init
  (defun java-compile ()
    "Traveling up the path, find build.xml file and run compile."
    (interactive)
    (save-buffer)
    (with-temp-buffer
      (while (and (not (or (file-exists-p "build.xml")
                           (file-exists-p "pom.xml")
                           (file-exists-p "build.gradle")))
                  (not (equal "/" default-directory)))
        (cd ".."))
      (call-interactively 'compile))))

(leaf groovy-mode
  :ensure t
  :mode (("\\.gradle$" . groovy-mode)))

(leaf *utils
  :bind ("C-c f" . my/copy-full-path-and-linenum)
  :init
  (require 'lisp-mnt)
  (defun my/copy-full-path-and-linenum ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (let
        ((msg  (format "%s:%d" (file-truename buffer-file-name) (line-number-at-pos))))

      (kill-new msg)
      (message "copied: %s" msg)))))

(leaf yasnippet
  :ensure t
  :commands yas-reload-all yas-global-mode
  :init
  (yas-reload-all)
  (yas-global-mode 1))

(leaf recentf-ext
  :ensure t
  :require t
  :defvar (recentf-auto-cleanup
           recentf-max-saved-items
           recentf-auto-save-timer
           run-with-idle-timer
           recentf-exclude)
  :setq ((recentf-auto-cleanup . 'never)
         (recentf-max-saved-items . 2000)
         (recentf-auto-save-timer .
                                  '(run-with-idle-timer 60 t 'recentf-save-list)))
  :config
  (add-to-list 'recentf-exclude "^/[^/:]+:")
  (add-to-list 'recentf-exclude "svn-commit\.tmp$")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG")
  (add-to-list 'recentf-exclude "bookmarks")
  (add-to-list 'recentf-exclude "\\.recentf")
  (add-to-list 'recentf-exclude "\\.revive\\.el"))

(leaf gtags
  :doc configuration for gtags.
  :el-get (gtags
           :url "https://cvs.savannah.gnu.org/viewvc/*checkout*/global/global/gtags.el")
  :commands gtags-mode
  :defer-config
  (defun my-c-mode-update-gtags ()
    (let* ((file (buffer-file-name (current-buffer)))
           (dir (directory-file-name (file-name-directory file))))
      (when (executable-find "global")
        (if (string= (shell-command-to-string "pgrep gtags") "")
            (start-process "gtags-update" nil
                           "global" "-uv")))))
  (defun my-tag-mode-insert-hook ()
    (gtags-mode 1)
    (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
    (local-set-key (kbd "M-,") 'helm-gtags-find-rtag)
    (local-set-key (kbd "M-/") 'helm-gtags-find-pattern)
    (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
    (local-set-key (kbd "M-*") 'helm-gtags-pop-stack))

  :hook ((after-save-hook . my-c-mode-update-gtags)
         (prog-mode-hook . my-tag-mode-insert-hook))
  :init
  (leaf helm-gtags
    :ensure t
    :commands (helm-gtags-find-tag
               helm-gtags-find-rtag
               helm-gtags-find-pattern
               helm-gtags-find-symbol
               helm-gtags-pop-stack)))

(leaf migemo
  :ensure t
  :defvar (migemo-command
           migemo-options
           migemo-user-dictionary
           migemo-regex-dictionary
           migemo-dictionary
           migemo-coding-system)
  :commands migemo-init
  :pre-setq ((migemo-command . "cmigemo")
             (migemo-options . '("-q" "--emacs"))
             (migemo-user-dictionary . nil)
             (migemo-regex-dictionary . nil)
             (migemo-dictionary . "/usr/local/share/migemo/utf-8/migemo-dict") ; mac
             (migemo-coding-system . 'utf-8-unix))
  :init
  (migemo-init))

(leaf helm
  :ensure t
  :defvar (helm-source-buffers-list
           helm-source-ls-git
           helm-source-ls-git-status
           helm-source-ls-git-buffers
           helm-ff-auto-update-initial-value
           helm-ff-transformer-show-only-basename
           helm-input-idle-delay
           helm-display-function
           projectile-project-root-files)
  :setq ((helm-ff-auto-update-initial-value . nil)
         (helm-ff-transformer-show-only-basename . nil)
         (helm-input-idle-delay . 0.2))
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . my-helm)
         ("C-:" . helm-resume)
         ("M-i" . helm-swoop)
         ("M-I" . helm-swoop-back-to-last-point)
         ("C-c M-i" . helm-multi-swoop)
         ("C-x M-i" . helm-multi-swoop-all))
  :commands (helm-mode)
  :init
  (leaf helm-ls-git
    :ensure t
    :after helm
    :require t)
  (require 'helm-config)
  (require 'helm-for-files)

  (helm-mode t)

  (setq helm-source-buffers-list
        (helm-make-source "Buffers" 'helm-source-buffers))

  (setq helm-source-ls-git-status
        (helm-ls-git-build-git-status-source)
        helm-source-ls-git
        (helm-ls-git-build-ls-git-source)
        helm-source-ls-git-buffers
        (helm-ls-git-build-buffers-source))

  (defun my-helm ()
    "`helm' for opening files all resource."
    (interactive)
    (if (helm-ls-git-not-inside-git-repo)
        (helm-other-buffer `(helm-source-buffers-list
                             helm-source-bookmarks
                             helm-source-recentf
                             helm-source-locate)
                           "*my helm*")
      (helm-other-buffer `(helm-source-ls-git-status
                           helm-source-buffers-list
                           helm-source-bookmarks
                           helm-source-ls-git-buffers
                           helm-source-ls-git
                           helm-source-recentf
                           helm-source-locate)
                         "*my helm*")))
  (setq helm-display-function (lambda (buf &optional _resume)
                                (split-window-vertically)
                                (switch-to-buffer buf)
                                ))

  (setq projectile-project-root-files
        '(".projectile"        ; projectile project marker
          "rebar.config"       ; Rebar project file
          "project.clj"        ; Leiningen project file
          "pom.xml"            ; Maven project file
          "build.sbt"          ; SBT project file
          "build.gradle"       ; Gradle project file
          "Gemfile"            ; Bundler file
          "requirements.txt"   ; Pip file
          "package.json"       ; npm package file
          "Gruntfile.js"       ; Grunt project file
          "bower.json"         ; Bower project file
          "composer.json"      ; Composer project file
          ".git"               ; Git VCS root dir
          ".hg"                ; Mercurial VCS root dir
          ".bzr"               ; Bazaar VCS root dir
          ".fslckout"          ; Fossil VCS root dir
          "_darcs"             ; Darcs VCS root dir
          ))
  (helm-autoresize-mode t))

(leaf clang-format
  :ensure t
  :commands (clang-format-buffer)
  :defvar (clang-format-modes
           clang-format-style)
  :pre-setq ((clang-format-modes . '(c++-mode c-mode java-mode))
             (clang-format-style . "google"))
  :hook (before-save-hook . my-clang-format-before-save)
  :init
  (defun my-clang-format-before-save ()
    "Usage: (add-hook 'before-save-hook 'my-clang-format-before-save)"
    (interactive)
    (if (member major-mode clang-format-modes)
        (clang-format-buffer))))

(leaf font-lock+
  :el-get emacsmirror/font-lock-plus)

(leaf hideshow
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

;; plunt-uml
(leaf flycheck-plantuml
  :ensure t
  :config
  (flycheck-plantuml-setup))

(leaf plantuml-mode
  :ensure t
  :commands plantuml-mode
  :defvar (plantuml-default-exec-mode
           plantuml-jar-path
           plantuml-output-type
           plantuml-indent-level)
  :pre-setq ((plantuml-default-exec-mode . 'jar)
             (plantuml-jar-path . "/usr/share/plantuml/plantuml.jar")
             (plantuml-output-type . "svg"))
  :setq ((plantuml-indent-level . 2))
  :bind (plantuml-mode-map
         ("C-c c" . my-plantuml-compile))
  :mode (("\\.puml$" . plantuml-mode)
         ("\\.plantuml$" . plantuml-mode))
  :init
  (defun my-plantuml-compile ()
    "Traveling up the path, find build.xml file and run compile."
    (interactive)
    (save-buffer)
    (with-temp-buffer
      (while (and (not (or (file-exists-p "makefile")
                           (file-exists-p "Makefile")))
                  (not (equal "/" default-directory)))
        (cd ".."))
      (call-interactively 'compile))))

;; yaml
(leaf yaml-mode
  :mode (("\\.yml$" . yaml-mode)
         ("\\.dig$" . yaml-mode)
         ("\\.yml-[a-zA-Z]+$" . yaml-mode))
  :init
  (add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(leaf emojify
  :ensure t
  :hook (after-init-hook . global-emojify-mode))

(leaf undohist
  :ensure t
  :commands undohist-initialize
  :hook (after-init-hook . undohist-initialize))

(leaf pyenv-mode-auto
  :ensure t
  :init (require 'pyenv-mode-auto))

(leaf undo-tree
  :doc show undo tree
  :ensure t
  :defvar (undo-tree-auto-save-history
           undo-tree-history-directory-alist)
  :commands global-undo-tree-mode
  :init
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist `(("." .,
                                             (expand-file-name "~/.emacs.d/undo-tree-hist/")))))


(leaf *objc-mode
  :init
  (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
  (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
  (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode)))

(leaf *octave-mode
  :mode (("\.m$" . octave-mode))
  :hook ((octave-mode-hook . (lambda ()
                               (abbrev-mode 1)
                               (auto-fill-mode 1)
                               (if (eq window-system 'x)
                                   (font-lock-mode 1))))))

(leaf windows
  :doc windows + revive
  :el-get byplayer/windows
  :bind (("C-x C-c" . see-you-again)
         ("C-x K" . kill-all-buffers))
  :defvar (win:switch-prefix
           win:use-frame)
  :defun (win:startup-with-window)
  :hook ((window-setup-hook . resume-windows))
  :pre-setq ((win:switch-prefix . "\C-cw"))
  :setq ((win:use-frame . nil))
  :init
  (win:startup-with-window))

(leaf *spell
  :doc spell check configuration
  :defvar (ispell-program-name ispell-grep-command)
  :setq ((ispell-program-name . "aspell")
         (ispell-grep-command . "grep"))
  :init
  (eval-after-load "ispell"
    '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]"))))

(leaf *hostconf
  :doc host specific configuration
  :init
  (let
      ((hostname "no_host")
       (hostconf ""))
    (setq hostname  (system-name))
    (if (null hostname)
        (setq hostname "no_host"))

    (setq hostname (downcase hostname))
    (setq hostname (car (split-string hostname "\\.")))

    (setq hostconf (expand-file-name (concat "~/.emacs.d/inits/hosts/"
                                             hostname ".el")))

    (if (file-exists-p hostconf)
        (load-file hostconf))))

(leaf *misc
  :doc misc configuration
  I would like to use setq setq-default macro but
  those generate eval-after-load '*misc so It doesn't work.
  :defvar (c-hungry-delete-key
           compilation-scroll-output)
  :pre-setq ((inhibit-startup-message . t))
  :custom ((truncate-lines . nil)
           (truncate-partial-width-windows . nil))
  :bind (("C-x <right>" . windmove-right)
         ("C-x <left>" . windmove-left)
         ("C-x <down>" . windmove-down)
         ("C-x <up>" . windmove-up))
  :init
  ;; support bat moad, ini mode
  (require 'generic-x)

  (set-frame-parameter nil 'fullscreen 'maximized)
  ;; no toolbar
  (tool-bar-mode 0)
  ;; show column
  (column-number-mode 1)
  ;; move window using meta
  (windmove-default-keybindings 'meta)

  (setq c-hungry-delete-key t)
  (setq confirm-kill-emacs 'y-or-n-p)
  (setq frame-title-format "%b")
  (setq compilation-scroll-output 'first-error)
  (setq indicate-empty-lines t)
  (setq indicate-buffer-boundaries 'right)
  (setq scroll-step 1)

  (setq-default indent-level 2)
  (setq-default tab-width 2)
  (setq-default indent-tabs-mode nil)
  )

(leaf *saveplace
  :setq-default ((save-place-limit . 1000))
  :init
  (save-place-mode 1))

(leaf init-loader
  :ensure t
  :defvar (init-loader-byte-compile init-loader-show-log-after-init)
  :setq ((init-loader-byte-compile . t)
         (init-loader-show-log-after-init . nil))
  :config
  (init-loader-load))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(imenu-list-position 'left t)
 '(imenu-list-size 30 t)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(elpy helm-for-files helm-config gradle-mode yaml-mode web-mode volatile-highlights undohist undo-tree smartparens scss-mode sclang-mode savekill ruby-block rubocopfmt rspec-mode robe rinari recentf-ext rainbow-mode pyenv-mode-auto py-autopep8 prettier-js posframe popwin phpunit php-mode org-sticky-header org-plus-contrib org-gcal neotree mozc-popup magit macrostep lsp-ui leaf-tree leaf-convert kotlin-mode keyfreq json-mode js2-mode init-loader helm-swoop helm-projectile helm-migemo helm-ls-git helm-gtags helm-go-package helm-flycheck helm-descbinds helm-c-yasnippet helm-ag groovy-mode go-eldoc gitignore-mode git-gutter flycheck-pos-tip flycheck-plantuml flycheck-kotlin flycheck-irony feature-mode expand-region emojify el-get dockerfile-mode crontab-mode company-quickhelp company-lsp company-irony company-go clang-format cider bind-key avy arduino-mode anzu all-the-icons-dired))
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "light gray")
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-comment-face ((t (:foreground "#D9333F"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
 '(web-mode-doctype-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground "#D9333F")))))

(unless (file-exists-p "~/.emacs.d/init.elc")
        (progn
          (message "build init.el. and all package files")
          (byte-recompile-directory "~/.emacs.d/elisp/" 0)
          (byte-recompile-directory "~/.emacs.d/el-get/" 0)
          (byte-recompile-directory "~/.emacs.d/elpa/" 0)
          (byte-recompile-directory "~/.emacs.d/inits/" 0)
          (byte-recompile-file "~/.emacs.d/init.el" t 0)))

;; reset gc value
(setq gc-cons-threshold 16777216) ; 16mb

(provide 'init)
;;; init.el ends here
