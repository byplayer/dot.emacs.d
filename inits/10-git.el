;;; package --- Summary
;;; Commentary:
;;; Code:
(use-package gitignore-mode
  :ensure t
  :defer t)

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode t))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         :map magit-mode-map
         ("c" . magit-commit-create)
         ("M-c" . magit-commit)
         ("P" . magit-push-current-to-upstream)
         ("M-P" . magit-push)
         ("F" . magit-pull-from-upstream)
         ("M-F" . magit-pull)))

(provide '10-git)
;;; 10-git.el ends here
