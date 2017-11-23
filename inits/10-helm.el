;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'helm-config)
(helm-mode t)

(require 'helm-ls-git)
(require 'helm-for-files)

;; for support lazy initialize
(setq helm-source-buffers-list
      (helm-make-source "Buffers" 'helm-source-buffers))

(defun my-helm ()
  "`helm' for opening files all resource."
  (interactive)
  (if (helm-ls-git-not-inside-git-repo)
    (helm-other-buffer `(helm-source-buffers-list
                         helm-source-bookmarks
                         helm-source-recentf
                         helm-source-locate)
                       "*my helm*")
    (helm-other-buffer `(helm-source-buffers-list
                         helm-source-bookmarks
                         helm-source-ls-git-status
                         helm-source-ls-git-buffers
                         helm-source-ls-git
                         helm-source-recentf
                         helm-source-locate)
                       "*my helm*")))

(setq helm-ff-auto-update-initial-value nil)
(setq helm-ff-transformer-show-only-basename nil)
(setq helm-input-idle-delay 0.2)

(global-set-key "\M-x" 'helm-M-x)
(global-set-key "\C-xb" 'my-helm)
(global-set-key "\M-y" 'helm-show-kill-ring)
(global-set-key (kbd "C-:") 'helm-resume)

;; open helm list top of new split window in current buffer
(setq helm-display-function (lambda (buf)
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

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

(helm-autoresize-mode t)

(provide '10-helm)
;;; 10-helm.el ends here
