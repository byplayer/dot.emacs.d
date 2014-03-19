;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'egg)

; no change
(setq egg-switch-to-buffer t)

;; git-gutter
(global-git-gutter-mode t)

(defun my-git-commit-mode-hook()
  (setq buffer-undo-list nil)
  )
(add-hook 'git-commit-mode-hook 'my-git-commit-mode-hook)

(provide '10-git)
;;; 10-git.el ends here
