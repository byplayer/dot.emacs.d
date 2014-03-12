;; package configuration
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

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

    ;;
    js2-mode

    ;; helm
    helm
    ac-helm
    helm-c-yasnippet
    helm-flycheck
    helm-git-files
    helm-projectile
    helm-ag
    helm-gtags
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
    ; egg

    ;; other
    undo-tree
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
