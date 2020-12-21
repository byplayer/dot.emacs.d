;;; package --- Summary
;;; Commentary:
;;; Code:

(setq confirm-kill-emacs 'y-or-n-p)
(set-frame-parameter nil 'fullscreen 'maximized)

;; windows + revive
(use-package windows
  :quelpa (windows :fetcher github :repo "byplayer/windows")
  :ensure t
  :bind (("C-x C-c" . see-you-again)
         ("C-x K" . kill-all-buffers)   ; This is revive finction
         )
  :init
  (setq win:switch-prefix "\C-cw")
  (setq win:use-frame nil)
  (win:startup-with-window)
  (add-hook 'window-setup-hook
            'resume-windows))

(provide '99-misc)
;;; 99-misc.el ends here
