;;; package --- Summary
;;; Commentary:
;;; Code:

;; reduce gc for loading init
(setq gc-cons-threshold most-positive-fixnum)

(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(add-to-list 'load-path "/opt/global/share/gtags/")

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

(leaf init-loader
  :ensure t
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
   '(windows rabbit-mode rd-mode font-lock+ helm-godoc yaml-mode web-mode volatile-highlights undohist undo-tree smartrep smartparens scss-mode sclang-mode savekill ruby-block rubocopfmt rspec-mode robe rinari recentf-ext rainbow-mode quelpa-use-package pyenv-mode-auto py-autopep8 prettier-js posframe popwin point-undo phpunit php-mode org-sticky-header org-plus-contrib org-gcal neotree multiple-cursors mozc-popup magit macrostep lsp-ui leaf-tree leaf-convert kotlin-mode keyfreq json-mode js2-mode init-loader helm-swoop helm-projectile helm-migemo helm-ls-git helm-gtags helm-go-package helm-flycheck helm-descbinds helm-c-yasnippet helm-ag groovy-mode go-eldoc gitignore-mode git-gutter flycheck-pos-tip flycheck-plantuml flycheck-kotlin flycheck-irony feature-mode expand-region emojify el-get dockerfile-mode crontab-mode company-quickhelp company-lsp company-jedi company-irony company-go clang-format cider avy auto-virtualenvwrapper arduino-mode anzu all-the-icons-dired))
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "light gray")
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

;; install packages
;; This value isn't used already but keep it to migrate use-package
(defvar my-installing-package-list
  '(
    ;; company
    company

    ;; ruby
    rinari
    ruby-block
    rspec-mode
    feature-mode
    robe
    rubocopfmt

    ;; javascript
    js2-mode

    ;; php
    php-mode
    phpunit

    ;; html
    web-mode
    rainbow-mode

    projectile
    migemo
    company

    ;; helm
    popup
    helm
    helm-c-yasnippet
    helm-flycheck
    helm-ls-git
    helm-projectile
    helm-ag
    helm-gtags
    helm-projectile
    helm-descbinds
    helm-migemo
    helm-swoop
    ; helm-package
    ; helm-rails

    ;; web
    web-mode
    scss-mode

    ;; region and cursor
    expand-region
    multiple-cursors
    smartrep

    ;; flymake
    flycheck
    flycheck-pos-tip

    ;; docker
    dockerfile-mode

    ;; go
    go-mode
    go-eldoc
    company-go

    ;; kotlin
    kotlin-mode
    flycheck-kotlin

    ;; groovy
    groovy-mode

    ;; irony
    irony
    company-irony
    flycheck-irony

    ;; other
    undo-tree
    point-undo
    markdown-mode
    yaml-mode
    yasnippet
    recentf-ext
    anzu
    savekill
    crontab-mode
    smartparens
    volatile-highlights
    popwin
    avy
    keyfreq

    ;; neotree
    all-the-icons
    neotree
    all-the-icons-dired

    imenu-list

    ;; org
    org
    org-plus-contrib

    ; c/c++
    clang-format

    prettier-js
    ))

(leaf dash
  :ensure t)

(leaf f
  :ensure t)

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


