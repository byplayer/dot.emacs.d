;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'helm-config)
(helm-mode t)

(require 'helm-git-files)

;; for support lazy initialize
(setq helm-source-buffers-list
      (helm-make-source "Buffers" 'helm-source-buffers))

(defun my-helm ()
  "`helm' for opening files all resource."
  (interactive)
  (vc-file-setprop default-directory 'git-root (helm-git-files:root-1))
  (helm-other-buffer `(helm-source-buffers-list
                       helm-source-bookmarks
                       helm-source-recentf
                       helm-git-files:modified-source
                       helm-git-files:untracked-source
                       helm-git-files:all-source
                       ,@(helm-git-files:submodule-sources
                          '(modified untracked all))
                       helm-source-locate)
                     "*my helm*"))

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

(require 'helm-ag)
(require 'projectile)
(defun helm-ag-from-project-root ()
  "Helm ag from project root."
  (interactive)
  (helm-ag--clear-variables)
  (let* ((project-root (projectile-project-root))
         (print project-root)
         (helm-ag-default-directory (if project-root
                                        project-root
                                      default-directory))
         (header-name (format "Search at %s" helm-ag-default-directory)))
    (helm-ag--query)
    (helm-attrset 'search-this-file nil helm-ag-source)
    (helm-attrset 'name (helm-ag--helm-header helm-ag--default-directory) helm-ag-source)
    (helm :sources (helm-ag--select-source) :buffer "*helm-ag*"
          :keymap helm-ag-map)))

(helm-autoresize-mode t)

(provide '10-helm)
;;; 10-helm.el ends here
