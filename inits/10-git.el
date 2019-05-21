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
  :bind (("C-x g" . magit-status)))

(provide '10-git)
;;; 10-git.el ends here
