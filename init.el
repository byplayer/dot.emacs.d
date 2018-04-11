;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(add-to-list 'load-path "/opt/global/share/gtags/")
(add-to-list 'load-path "~/.emacs.d/elisp/bat-mode/")

(require 'cl)

;; install packages
(defvar my-installing-package-list
  '(
    ;; init-loader
    init-loader

    ;; for auto-complete
    popup
    fuzzy
    pos-tip
    auto-complete

    ;; color theme
    color-theme

    ;; ruby
    rvm
    rhtml-mode
    rinari
    ruby-block
    rspec-mode
    feature-mode

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
    helm
    ac-helm
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

    ;; auto complete
    ac-ispell

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
    go-autocomplete
    company-go

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
    neotree
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode web-mode volatile-highlights undo-tree smartrep smartparens savekill rvm ruby-block rspec-mode rinari rhtml-mode revive recentf-ext rainbow-mode popwin point-undo phpunit php-mode neotree multiple-cursors markdown-mode js2-mode init-loader helm-swoop helm-projectile helm-migemo helm-ls-git helm-gtags helm-flycheck helm-descbinds helm-c-yasnippet helm-ag go-eldoc go-autocomplete gitignore-mode git-gutter git-commit-mode fuzzy flycheck-pos-tip feature-mode expand-region egg dockerfile-mode crontab-mode company-go color-theme anzu ac-ispell ac-helm)))
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
