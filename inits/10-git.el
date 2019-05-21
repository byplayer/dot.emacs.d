;;; package --- Summary
;;; Commentary:
;;; Code:
(use-package git-commit-mode
  :ensure t
  :init
  (defun my-git-commit-mode-hook()
    (progn
      (setq buffer-undo-list nil)
      (flyspell-mode 1)
      (turn-on-auto-fill)))
  (add-hook 'git-commit-mode-hook 'my-git-commit-mode-hook))

(use-package gitignore-mode
  :ensure t
  :defer t)

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode t))

(use-package magit
  :ensure t
  :defer t
  :bind (("C-x g" . magit-status)))

(provide '10-git)
;;; 10-git.el ends here
