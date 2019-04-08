;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(add-to-list 'load-path "/opt/global/share/gtags/")
(add-to-list 'load-path "~/.emacs.d/elisp/bat-mode/")
(add-to-list 'load-path "~/.emacs.d/elisp/font-lock-plus/")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((eval setq-local default-directory
           (expand-file-name
            (concat
             (file-name-directory
              (buffer-file-name))
             "..")))
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby"))))
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "light gray")
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))

(require 'cl)

;; install packages
(defvar my-installing-package-list
  '(
    ;; init-loader
    init-loader

    ;; color theme
    color-theme

    ;; company
    company
    company-quickhelp

    ;; ruby
    rhtml-mode
    rinari
    ruby-block
    rspec-mode
    feature-mode
    robe

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

    ;; region and cursor
    expand-region
    multiple-cursors
    smartrep

    ;; flymake
    flycheck
    flycheck-pos-tip

    ;; git
    git-commit-mode
    gitignore-mode
    git-gutter
    egg

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

    mozc
    mozc-popup

    ; c/c++
    google-c-style
    clang-format
    ))

(let ((not-installed (loop for x in my-installing-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

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
(add-to-list 'load-path "~/.emacs.d/auto-install")

;; init-loader
;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
;; デフォルトで"~/.emacs.d/inits"以下のファイルをロードする
(require 'init-loader)
(setq init-loader-byte-compile t)
(setq init-loader-show-log-after-init nil)
(init-loader-load)

(provide 'init)
;;; init.el ends here
