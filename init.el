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

    ;; helm
    helm
    ac-helm
    helm-c-yasnippet
    helm-flycheck
    helm-git-files
    helm-projectile
    helm-ag
    helm-gtags
    helm-projectile
    helm-descbinds
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
    rainbow-delimiters
    volatile-highlights
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
