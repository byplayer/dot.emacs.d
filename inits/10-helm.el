(require 'helm-config)
(helm-mode t)

(require 'helm-git-files)

(defun my-helm ()
  "`helm' for opening files all resource."
  (interactive)
  (vc-file-setprop default-directory 'git-root (helm-git-files:root-1))
  (helm-other-buffer `(helm-source-buffers-list
                       helm-source-locate
                       helm-source-recentf
                       helm-git-files:modified-source
                       helm-git-files:untracked-source
                       helm-git-files:all-source
                       ,@(helm-git-files:submodule-sources
                          '(modified untracked all))
                       helm-source-bookmarks
                       helm-c-source-files-in-current-dir)
                     "*my helm*"))

(setq helm-ff-auto-update-initial-value nil)
(setq helm-ff-transformer-show-only-basename nil)
(setq helm-input-idle-delay 0.2)

(global-set-key "\M-x" 'helm-M-x)
(global-set-key "\C-xb" 'my-helm)
(global-set-key "\M-y" 'helm-show-kill-ring)

;; open helm list top of new split window in current buffer
(setq helm-display-function (lambda (buf)
                             (split-window-vertically)
                             (switch-to-buffer buf)
                             ))

(require 'helm-ag)
(require 'projectile)
(defun helm-ag-from-project-root ()
  (interactive)
  (let* ((project-root (projectile-project-root))
         (print project-root)
         (helm-ag-default-directory (if project-root
                                        project-root
                                      default-directory))
         (header-name (format "Search at %s" helm-ag-default-directory)))
    (helm-attrset 'search-this-file nil helm-ag-source)
    (helm-attrset 'name header-name helm-ag-source)
    (helm :sources (helm-ag--select-source) :buffer "*helm-ag*")))
