;;; package --- Summary
;;; Commentary:
;;; Author: byplayer
;;; Code:

;; reduce gc for loading init
(setq gc-cons-threshold most-positive-fixnum)

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (defvar leaf--load-file-name nil)

  (leaf leaf
    :config
    (leaf leaf-convert :ensure t)
    (leaf leaf-tree
      :ensure t
      :custom ((imenu-list-size . 30)
               (imenu-list-position . 'left))))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

(leaf *custom-file
  :setq (custom-file . "~/.emacs.d/custom.el"))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

;; (leaf lsp-mode
;;   :ensure t
;;   :commands (lsp lsp-deferred)
;;   :custom (lsp-rust-server . 'rust-analyzer)
;;   :bind ("C-c h" . lsp-describe-thing-at-point)
;;   :hook ((go-mode-hook . lsp-deferred)
;;          (rust-mode-hook . lsp)
;;          (lsp-mode-hook . (lambda()
;;               (local-set-key (kbd "M-*") 'xref-pop-marker-stack)
;;               (local-set-key (kbd "M-.") 'xref-find-definitions)
;;               (local-set-key (kbd "M-/") 'xref-find-references)))))

;; (leaf lsp-ui
;;   :ensure t
;;   :after lsp-mode
;;   :commands lsp-ui-mode)

(leaf company-quickhelp
  :doc help support for company
  :ensure t)

(leaf company-emoji
  :ensure t)

(leaf *set-emoji
  :after company-emoji
  :init (add-to-list 'company-emojis '#(":pencil:" 0 1 (:unicode "📝"))))

(leaf company
  :ensure t
  :commands global-company-mode
  :bind (("C-M-i" . company-complete))
  :bind (company-active-map
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
           company-dabbrev-char-regexp
           company-dabbrev-downcase
           completion-ignore-case
           company-show-quick-access)
  :setq ((company-dabbrev-downcase . nil)
         (completion-ignore-case . t)
         (company-show-quick-access . t)
         (company-idle-delay . 0.5)
         (company-minimum-prefix-length . 2)
         (company-selection-wrap-around . t))
  :defun (company-mode/backend-with-yas
          edit-category-table-for-company-dabbrev)
  :init
  (global-company-mode)
  (company-quickhelp-mode +1)
  (add-to-list 'company-backends 'company-emoji)
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
  (setq company-dabbrev-char-regexp "\\(\\cs\\|_\\|\\+\\|-\\)")

  :config
  (let ((map company-active-map))
    (mapc (lambda (x)
            (define-key map (format "%d" x)
              `(lambda () (interactive) (company-complete-number ,x))))
          (number-sequence 0 9))))

(leaf company-lsp
  :ensure t
  :after company
  :commands company-lsp)

(leaf company-statistics
  :ensure t
  :after company
  :init
  (company-statistics-mode))

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

;; (leaf *lookup
;;   :doc lookup configuration
;;   lookup directory is builded files of the below lookup2 sources
;;   https://github.com/lookup2/lookup2
;;   :defvar (lookup-enable-splash
;;            lookup-search-agents)
;;   :init
;;   (add-to-list 'load-path "~/.emacs.d/elisp/lookup/lookup")
;;   (load "lookup-autoloads")
;;   (eval-after-load 'flycheck
;;     '(progn
;;        (setq lookup-enable-splash nil)
;;                                         ; (global-set-key "\C-c\C-l" 'lookup)
;;        (global-set-key (kbd "C-x W") 'lookup-region)
;;        (global-set-key (kbd "C-x w") 'lookup-pattern)

;;        (setq lookup-search-agents
;;              '((ndeb "~/dic/LDOCE4")
;;                (ndeb "~/dic/sperdic200")
;;                (ndeb "~/dic/edict2"))))))

;; (leaf expand-region
;;   :doc expand region
;;   :ensure t
;;   :bind (("C-<" . er/expand-region)
;;          ("C-M-," . er/contract-region)))

;; (leaf avy
;;   :doc quick search
;;   :ensure t
;;   :bind (("C-c j" . avy-goto-word-1)))

;; (leaf winner
;;   :init
;;   (winner-mode))

;; (leaf *config-for-c
;;   :doc configuration for c/c++
;;   :hook (c-mode-common-hook . my/c-mode-hook)
;;   :init
;;   (leaf irony
;;     :doc C/C++ suggestion tool
;;     :ensure t
;;     :require t
;;     :defvar (flycheck-clang-language-standard c-basic-offset irony-supported-major-modes)
;;     :hook (irony-mode-hook . (lambda()
;;                                (irony-cdb-autosetup-compile-options)
;;                                (add-to-list
;;                                 (make-local-variable 'company-backends)
;;                                 '(company-irony :with company-yasnippet))))
;;     :setq (flycheck-clang-language-standard . "c++14"))

;;   (defun my/c-mode-hook ()
;;     (c-set-offset 'statement-block-intro 2)
;;     (setq c-basic-offset 2)
;;     (turn-on-font-lock)
;;     (local-set-key "\C-cc" 'compile)
;;     (when (member major-mode irony-supported-major-modes)
;;       (irony-mode 1))))

;; (leaf gitignore-mode
;;   :ensure t)

;; (leaf git-gutter
;;   :ensure t
;;   :init
;;   (global-git-gutter-mode t)
;;   :config
;;   (set-face-foreground 'git-gutter:added    "OliveDrab")
;;   (set-face-foreground 'git-gutter:deleted  "DarkRed")
;;   (set-face-foreground 'git-gutter:modified "DarkMagenta"))

;; (leaf magit
;;   :ensure t
;;   :bind (("C-x g" . magit-status))
;;   :bind (magit-mode-map
;;          ("c" . magit-commit-create)
;;          ("M-c" . magit-commit)
;;          ("P" . magit-push-current-to-upstream)
;;          ("M-P" . magit-push)
;;          ("F" . magit-pull-from-upstream)
;;          ("M-F" . magit-pull)))

;; (leaf go-mode
;;   :doc for go lang development
;;   :ensure t
;;   :after company
;;   :mode (("\.go$" . go-mode))
;;   :defvar (indent-level)
;;   :hook ((go-mode-hook . (lambda()
;;                            (go-eldoc-setup)
;;                            (company-mode)
;;                            (flycheck-mode)
;;                            (setq indent-level 4)
;;                            (setq c-basic-offset 4)
;;                            (setq tab-width 4)
;;                            (define-key go-mode-map (kbd "C-c c") 'go-compile)
;;                            (add-to-list
;;                             (make-local-variable 'company-backends)
;;                             '(company-go :with company-yasnippet))))
;;          (go-mode-hook . lsp-go-install-save-hooks))
;;   :bind (go-mode-map
;;          ("C-c d" . helm-godoc))

;;   :defun (lsp-format-buffer lsp-organize-imports)

;;   :init
;;   (leaf helm-godoc
;;     :el-get syohex/emacs-helm-godoc
;;     :commands helm-godoc)

;;   (leaf helm-go-package
;;     :ensure t
;;     :commands helm-go-package
;;     :defer-config (go-mode (substitute-key-definition
;;                             'go-import-add 'helm-go-package go-mode-map)))

;;   (defun go-compile ()
;;     "Traveling up the path, find build.xml file and run compile."
;;     (interactive)
;;     (save-buffer)
;;     (with-temp-buffer
;;       (while (and (not (or (file-exists-p "go.mod")
;;                            (file-directory-p ".git")))
;;                   (not (equal "/" default-directory)))
;;         (cd ".."))
;;       (call-interactively 'compile)))

;;   (defun lsp-go-install-save-hooks ()
;;     (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;     (add-hook 'before-save-hook #'lsp-organize-imports t t)))

;; (leaf *sh-mode-config
;;   :doc sh-mode configuration
;;   :defvar (sh-basic-offset
;;            sh-indent-after-continuation
;;            sh-indent-for-continuation)
;;   :hook ((sh-mode-hook . (lambda ()
;;                            (setq sh-basic-offset 2
;;                                  sh-indent-after-continuation nil
;;                                  sh-indent-for-continuation 0)))))

;; (leaf python
;;   :ensure t
;;   :mode (("\\.py$" . python-mode)))

;; (leaf pyenv
;;   :el-get aiguofer/pyenv.el
;;   :commands global-pyenv-mode
;;   :init
;;   (global-pyenv-mode))

;; (leaf py-autopep8
;;   :ensure t
;;   :commands (py-autopep8-before-save py-autopep8-enable-on-save)
;;   :hook (python-mode-hook . py-autopep8-enable-on-save))

;; (leaf elpy
;;   :disabled t
;;   :ensure t
;;   :init
;;   (elpy-enable))

;; (leaf php-mode
;;   :ensure t
;;   :mode (("\\.php$" . php-mode)
;;          ("\\.inc$" . php-mode))
;;   :bind (php-mode-map
;;          ("C-M-i" . company-complete)
;;          ("C-c , s" . phpunit-current-test)
;;          ("C-c , v" . phpunit-current-class)
;;          ("C-c , a" . phpunit-current-project))
;;   :defun (php-set-style)
;;   :hook (php-mode-hook . (lambda()
;;              (php-set-style "php")
;;              (setq c-basic-offset 4)
;;              (setq tab-width 4)
;;              (setq indent-tabs-mode t))))

;; (leaf :java
;;   :doc
;;   configuration for java
;;   :defvar (java-mode-map)
;;   :hook ((java-mode-hook . (lambda ()
;;                              (setq c-basic-offset 2)
;;                              (setq tab-width 2)
;;                              (setq indent-tabs-mode nil)
;;                              (define-key java-mode-map (kbd "C-c c") 'java-compile))))
;;   :init
;;   (defun java-compile ()
;;     "Traveling up the path, find build.xml file and run compile."
;;     (interactive)
;;     (save-buffer)
;;     (with-temp-buffer
;;       (while (and (not (or (file-exists-p "build.xml")
;;                            (file-exists-p "pom.xml")
;;                            (file-exists-p "build.gradle")))
;;                   (not (equal "/" default-directory)))
;;         (cd ".."))
;;       (call-interactively 'compile))))

;; (leaf groovy-mode
;;   :ensure t
;;   :mode (("\\.gradle$" . groovy-mode)))

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

;; (leaf typescript-mode
;;   :ensure t
;;   :mode (("\\.ts$" . typescript-mode)))

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

;; (leaf gtags
;;   :doc configuration for gtags.
;;   :el-get (gtags
;;            :url "https://cvs.savannah.gnu.org/viewvc/*checkout*/global/global/gtags.el")
;;   :commands gtags-mode
;;   :defer-config
;;   (defun my-c-mode-update-gtags ()
;;     (let* ((file (buffer-file-name (current-buffer)))
;;            (dir (directory-file-name (file-name-directory file))))
;;       (when (executable-find "global")
;;         (if (string= (shell-command-to-string "pgrep gtags") "")
;;             (start-process "gtags-update" nil
;;                            "global" "-uv")))))
;;   (defun my-tag-mode-insert-hook ()
;;     (gtags-mode 1)
;;     (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
;;     (local-set-key (kbd "M-,") 'helm-gtags-find-rtag)
;;     (local-set-key (kbd "M-/") 'helm-gtags-find-pattern)
;;     (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
;;     (local-set-key (kbd "M-*") 'helm-gtags-pop-stack))

;;   :hook ((after-save-hook . my-c-mode-update-gtags)
;;          (prog-mode-hook . my-tag-mode-insert-hook))
;;   :init
;;   (leaf helm-gtags
;;     :ensure t
;;     :commands (helm-gtags-find-tag
;;                helm-gtags-find-rtag
;;                helm-gtags-find-pattern
;;                helm-gtags-find-symbol
;;                helm-gtags-pop-stack)))

;; (leaf migemo
;;   :ensure t
;;   :defvar (migemo-command
;;            migemo-options
;;            migemo-user-dictionary
;;            migemo-regex-dictionary
;;            migemo-dictionary
;;            migemo-coding-system)
;;   :commands migemo-init
;;   :pre-setq ((migemo-command . "cmigemo")
;;              (migemo-options . '("-q" "--emacs"))
;;              (migemo-user-dictionary . nil)
;;              (migemo-regex-dictionary . nil)
;;              (migemo-dictionary . "/usr/local/share/migemo/utf-8/migemo-dict") ; mac
;;              (migemo-coding-system . 'utf-8-unix))
;;   :init
;;   (migemo-init))

;; (leaf projectile
;;   :ensure t
;;   :defvar (projectile-project-root-files)
;;   :pre-setq (projectile-project-root-files .
;;                                            '(".projectile"        ; projectile project marker
;;                                              "rebar.config"       ; Rebar project file
;;                                              "project.clj"        ; Leiningen project file
;;                                              "pom.xml"            ; Maven project file
;;                                              "build.sbt"          ; SBT project file
;;                                              "build.gradle"       ; Gradle project file
;;                                              "Gemfile"            ; Bundler file
;;                                              "requirements.txt"   ; Pip file
;;                                              "package.json"       ; npm package file
;;                                              "Gruntfile.js"       ; Grunt project file
;;                                              "bower.json"         ; Bower project file
;;                                              "composer.json"      ; Composer project file
;;                                              ".git"               ; Git VCS root dir
;;                                              ".hg"                ; Mercurial VCS root dir
;;                                              ".bzr"               ; Bazaar VCS root dir
;;                                              ".fslckout"          ; Fossil VCS root dir
;;                                              "_darcs"             ; Darcs VCS root dir
;;                                              ))
;;   :bind (("C-c c" . projectile-compile-project)))

(leaf helm
  :ensure t
  :defun (helm-make-source
	     helm-ls-git-build-git-status-source
             helm-ls-git-build-buffers-source
           helm-ls-git-build-ls-git-source
           helm-ls-git-not-inside-git-repo
           helm-autoresize-mode)
  :defvar (helm-source-buffers-list
           helm-source-ls-git
           helm-source-ls-git-status
           helm-source-ls-git-buffers
           helm-ff-auto-update-initial-value
           helm-ff-transformer-show-only-basename
           helm-input-idle-delay
           helm-display-function
           helm-buffer-max-length)
  :setq ((helm-ff-auto-update-initial-value . nil)
         (helm-ff-transformer-show-only-basename . nil)
         (helm-input-idle-delay . 0.2)
         (helm-buffer-max-length . 40))
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
	 ("C-x b" . my/helm)
         ("C-:" . helm-resume)
         ("M-i" . helm-swoop)
         ("M-I" . helm-swoop-back-to-last-point)
         ("C-c M-i" . helm-multi-swoop)
         ("C-x M-i" . helm-multi-swoop-all))
  :require helm-for-files

  :init
  (leaf helm-ls-git
    :ensure t
    :after helm
    :require t)

  :config
  (helm-mode t)

  (setq helm-source-ls-git-status
        (helm-ls-git-build-git-status-source)
        helm-source-ls-git
        (helm-ls-git-build-ls-git-source)
        helm-source-ls-git-buffers
        (helm-ls-git-build-buffers-source))

  (defun my/helm ()
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
  (helm-autoresize-mode t))

;; (leaf clang-format
;;   :ensure t
;;   :commands (clang-format-buffer)
;;   :defvar (clang-format-modes
;;            clang-format-style)
;;   :pre-setq ((clang-format-modes . '(c++-mode c-mode java-mode))
;;              (clang-format-style . "google"))
;;   :hook (before-save-hook . my-clang-format-before-save)
;;   :init
;;   (defun my-clang-format-before-save ()
;;     "Usage: (add-hook 'before-save-hook 'my-clang-format-before-save)"
;;     (interactive)
;;     (if (member major-mode clang-format-modes)
;;         (clang-format-buffer))))

;; (leaf font-lock+
;;   :el-get emacsmirror/font-lock-plus)

(leaf hideshow
  :ensure t
  :commands (hs-minor-mode)
  :bind (("C-#" . hs-toggle-hiding)
         ("C-+" . hs-show-all)
         ("C-=" . hs-hide-all))
  :hook (prog-mode-hook . my/add-hs-minor-mode)
  :config
  ;; Set up hs-mode (HideShow) for Ruby
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do")) ; Block start
                 ,(rx (or "end"))                       ; Block end
                 ,(rx (or "#" "=begin"))                ; Comment start
                 ruby-forward-sexp nil))
  (defun my/add-hs-minor-mode()
    (hs-minor-mode 1)))

;; plunt-uml
;; (leaf flycheck-plantuml
;;   :ensure t
;;   :config
;;   (flycheck-plantuml-setup))

;; (leaf plantuml-mode
;;   :ensure t
;;   :commands plantuml-mode
;;   :defvar (plantuml-default-exec-mode
;;            plantuml-jar-path
;;            plantuml-output-type
;;            plantuml-indent-level)
;;   :pre-setq ((plantuml-default-exec-mode . 'jar)
;;              (plantuml-jar-path . "/usr/share/plantuml/plantuml.jar")
;;              (plantuml-output-type . "svg"))
;;   :setq ((plantuml-indent-level . 2))
;;   :bind (plantuml-mode-map
;;          ("C-c c" . my-plantuml-compile))
;;   :mode (("\\.puml$" . plantuml-mode)
;;          ("\\.plantuml$" . plantuml-mode))
;;   :init
;;   (defun my-plantuml-compile ()
;;     "Traveling up the path, find build.xml file and run compile."
;;     (interactive)
;;     (save-buffer)
;;     (with-temp-buffer
;;       (while (and (not (or (file-exists-p "makefile")
;;                            (file-exists-p "Makefile")))
;;                   (not (equal "/" default-directory)))
;;         (cd ".."))
;;       (call-interactively 'compile))))

;; yaml
;; (leaf yaml-mode
;;   :mode (("\\.yml$" . yaml-mode)
;;          ("\\.dig$" . yaml-mode)
;;          ("\\.yml-[a-zA-Z]+$" . yaml-mode))
;;   :init
;;   (add-hook 'yaml-mode-hook
;;           '(lambda ()
;;              (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

;; (leaf emojify
;;   :ensure t
;;   :hook (after-init-hook . global-emojify-mode))

;; (leaf pyenv-mode-auto
;;   :ensure t
;;   :init (require 'pyenv-mode-auto))

;; (leaf undo-tree
;;   :doc show undo tree
;;   :ensure t
;;   :defvar (undo-tree-auto-save-history
;;            undo-tree-history-directory-alist)
;;   :commands global-undo-tree-mode
;;   :init
;;   (global-undo-tree-mode)
;;   (setq undo-tree-auto-save-history t
;;         undo-tree-history-directory-alist `(("." .,
;;                                              (expand-file-name "~/.emacs.d/undo-tree-hist/")))))


;; (leaf *objc-mode
;;   :init
;;   (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
;;   (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
;;   (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode)))

;; (leaf *octave-mode
;;   :mode (("\.m$" . octave-mode))
;;   :hook ((octave-mode-hook . (lambda ()
;;                                (abbrev-mode 1)
;;                                (auto-fill-mode 1)
;;                                (if (eq window-system 'x)
;;                                    (font-lock-mode 1))))))

;; (leaf rainbow-mode
;;   :ensure t
;;   :hook ((css-mode-hook . rainbow-mode)
;;          (scss-mode-hook . rainbow-mode)
;;          (lisp-mode-hook . rainbow-mode)
;;          (emacs-lisp-mode-hook . rainbow-mode)))

;; (leaf rust-mode
;;   :ensure t
;;   :custom (rust-format-on-save . t))

;; (leaf cargo
;;   :ensure t
;;   :hook (rust-mode-hook . cargo-minor-mode))

(leaf *desktop
  :doc for desk top save mode
  :init
  (desktop-save-mode 1))

;; (leaf *spell
;;   :doc spell check configuration
;;   :defvar (ispell-program-name ispell-grep-command)
;;   :setq ((ispell-program-name . "aspell")
;;          (ispell-grep-command . "grep"))
;;   :init
;;   (eval-after-load "ispell"
;;     '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]"))))

;; (leaf *hostconf
;;   :doc host specific configuration
;;   :init
;;   (let
;;       ((hostname "no_host")
;;        (hostconf ""))
;;     (setq hostname  (system-name))
;;     (if (null hostname)
;;         (setq hostname "no_host"))

;;     (setq hostname (downcase hostname))
;;     (setq hostname (car (split-string hostname "\\.")))

;;     (setq hostconf (expand-file-name (concat "~/.emacs.d/inits/hosts/"
;;                                              hostname ".el")))

;;     (if (file-exists-p hostconf)
;;         (load-file hostconf))))

(leaf smartparens
  :doc "for smart parens"
  :ensure t
  :require smartparens-config
  :config
  (smartparens-global-mode t))

(leaf smart-beginning-of-line
  :el-get byplayer/smart-beginning-of-line
  :bind
  ("\C-a" . smart-beginning-of-line)
  ([home] . smart-beginning-of-line))

(leaf generic-x
  :doc support bat moad, ini mode
  :require generic-x)

(leaf *set-bindings
  :doc set key bindings. Don't mix set-variables because set variables doesn't work
  :bind
  ("C-m" . default-indent-new-line)
  ("C-z" . scroll-down)
  ("C-x <right>" . windmove-right)
  ("C-x <left>" . windmove-left)
  ("C-x <down>" . windmove-down)
  ("C-x <up>" . windmove-up)
  ("C-x h" . split-window-right)
  ("C-x v" . split-window-below))

(leaf *set-variables
  :doc set variables. Don't mix set bindings. This section doesn't work when mix.
  :setq-default
  (indent-level . 2)
  (tab-width . 2)
  (indent-tabs-mode . nil)
  
  :setq
  (confirm-kill-emacs . 'y-or-n-p)
  (scroll-step . 1)
  (indicate-empty-lines . 1)
  (frame-title-format . "%b")
  (indicate-buffer-boundaries . 'right)
  (compilation-scroll-output . 'first-error)
  (ring-bell-function . 'ignore)
  (inhibit-startup-message . t)
  (c-hungry-delete-key . 1)
  (truncate-lines . nil)
  (truncate-partial-width-windows . nil)

  :config
  (put 'upcase-region 'disabled nil)
  (set-frame-parameter nil 'fullscreen 'maximized)
  ;; no toolbar
  (tool-bar-mode -1)
  ;; show column
  (column-number-mode 1)
  ;; move window using meta
  (windmove-default-keybindings 'meta)
  ;; remove region text when select region and input
  (delete-selection-mode 1))

(leaf *backup-files
  :init
  ;; :setq で正しく設定する方法が分からない
  ;; デフォルトで勝手に作られるbackupファイルの保存先を任意箇所にする
  (setq backup-directory-alist
        (cons (cons ".*" (expand-file-name "~/.emacs.d/backup-file"))
              backup-directory-alist))

  ;; :setq で正しく設定する方法が分からない
  ;; 編集中の異常終了の際などに作られるauto-saveファイルの保存先を任意箇所にする
  (setq auto-save-file-name-transforms
        `((".*", (expand-file-name "~/.emacs.d/auto-save-file") t)))

  (setq version-control t)      ; version control for backup
  (setq kept-new-versions 10)   ; keep 10 new files
  (setq kept-old-versions 10)   ; keep 10 old files
  (setq delete-old-versions t)  ; delete old files without confirmation
  (setq vc-make-backup-files t) ; backup under version control

  ;; disable lock file
  (setq create-lockfiles nil)
  )

(leaf *kill-all-buffers
  :bind
  ("C-x K" . kill-all-buffers)
  :init
  (defun kill-all-buffers()
    (interactive)
    (yes-or-no-p "kill all buffers? ")
    (dolist (buf (buffer-list))
      (kill-buffer buf))))

(leaf auto-async-byte-compile
  :doc auto compile elisp after save
  :ensure t
  :hook (emacs-lisp-mode-hook . enable-auto-async-byte-compile-mode))

(leaf *saveplace
  :setq-default ((save-place-limit . 1000))
  :config
  (save-place-mode 1))

(leaf *platform-depends
  :doc "set platform dependent configuration"
  :init
  (leaf *cocoa
    :doc "set mac configuration"
    :if (equal window-system 'mac)
    :setq (mac-option-modifier . 'meta)
    :init
    ;; for C-x/M-x with FEP issue on Mac
    (mac-auto-ascii-mode 1)))

(leaf *byte-compile-init-files
  :doc "byte compile init files when init.elc doesn't exist"
  :setq (load-prefer-newer . t)
  :defun my/byte-compile-init-files
  :init
  (leaf *auto-compile-init-files
    :unless (file-exists-p "~/.emacs.d/init.elc")
    :init
    (defun my/byte-compile-init-files()
    "To byte compile init files."
    (interactive)
    (progn
      (byte-recompile-directory "~/.emacs.d/elisp/" 0)
      (byte-recompile-directory "~/.emacs.d/el-get/" 0)
      (byte-recompile-directory "~/.emacs.d/elpa/" 0)
      (byte-recompile-directory "~/.emacs.d/themes/" 0)
      (byte-recompile-file "~/.emacs.d/init.el" t 0)))
    
    (my/byte-compile-init-files)))


;; reset gc value
(setq gc-cons-threshold 16777216) ; 16mb

(provide 'init)
