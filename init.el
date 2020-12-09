;;; package --- Summary
;;; Commentary:
;;; Code:
(setq quelpa-update-melpa-p nil)

(require 'package)
(setq package-archives
      '(("org"          . "http://orgmode.org/elpa/")
        ("melpa"        . "http://melpa.org/packages/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")
        ("gnu"          . "http://elpa.gnu.org/packages/")))

(package-initialize)

(add-to-list 'load-path "/opt/global/share/gtags/")
(add-to-list 'load-path "~/.emacs.d/elisp/font-lock-plus/")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(scss-mode reinbow-mode company-lsp lsp-ui lv lsp-mode pyenv-mode-auto undohist org-todoist request-deferred request org-gcal company-jedi jedi-core jedi auto-virtualenvwrapper virtualenvwrapper rd-mode rabbit-mode font-lock+ quelpa-use-package quelpa let-alist go-mode magit sclang-mode yaml-mode web-mode volatile-highlights undo-tree smartrep smartparens savekill ruby-block rspec-mode robe rinari revive recentf-ext rainbow-mode popwin point-undo phpunit php-mode org-plus-contrib neotree multiple-cursors mozc-popup markdown-mode kotlin-mode keyfreq json-mode js2-mode init-loader imenu-list helm-swoop helm-projectile helm-migemo helm-ls-git helm-gtags helm-go-package helm-flycheck helm-descbinds helm-c-yasnippet helm-ag groovy-mode go-eldoc flycheck-pos-tip flycheck-kotlin flycheck-irony feature-mode expand-region dockerfile-mode crontab-mode company-quickhelp company-irony company-go clang-format avy anzu all-the-icons-dired))
 '(safe-local-variable-values
   '((clang-format-modes quote nil)
     (eval setq-local default-directory
           (expand-file-name
            (concat
             (file-name-directory
              (buffer-file-name))
             "..")))
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby")))
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "light gray")
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

;; install packages
;; This value isn't used already but keep it to migrate use-package
(defvar my-installing-package-list
  '(
    ;; init
    use-package
    init-loader

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
    revive
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

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
(require 'quelpa-use-package)
(require 'use-package)
(require 'dash)
(require 'f)

(defun was-compiled-p (path)
  "Does the directory at PATH contain any .elc files?"
  (--any-p (f-ext? it "elc") (f-files path)))

(defun ensure-packages-compiled ()
  "If any packages installed with package.el aren't compiled yet, compile them."
  (--each (f-directories package-user-dir)
    (unless (was-compiled-p it)
      (byte-recompile-directory it 0))))

(ensure-packages-compiled)

;; load-path
(add-to-list 'load-path "~/.emacs.d/elisp")

;; init-loader
;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
;; デフォルトで"~/.emacs.d/inits"以下のファイルをロードする
(require 'init-loader)
(setq init-loader-byte-compile t)
(setq init-loader-show-log-after-init nil)
(init-loader-load)

(provide 'init)
;;; init.el ends here
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
