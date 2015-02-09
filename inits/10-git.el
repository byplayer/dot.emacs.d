;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'egg)
(require 'git-commit-mode)

; no change
(setq egg-switch-to-buffer t)

;; git-gutter
(global-git-gutter-mode t)

(defun my-git-commit-mode-hook()
  (progn
    (setq buffer-undo-list nil)
    (flyspell-mode)
    (turn-on-auto-fill)))
(add-hook 'git-commit-mode-hook 'my-git-commit-mode-hook)

(provide '10-git)
;;; 10-git.el ends here
