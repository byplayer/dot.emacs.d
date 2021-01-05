;;; package --- Summary
;;; Commentary:
;;; Code:

(setq confirm-kill-emacs 'y-or-n-p)
(set-frame-parameter nil 'fullscreen 'maximized)

;; windows + revive
(leaf windows
  :el-get byplayer/windows
  :bind (("C-x C-c" . see-you-again)
         ("C-x K" . kill-all-buffers))
  :hook ((window-setup-hook . resume-windows))
  :init
  (setq win:switch-prefix "\C-cw")
  (setq win:use-frame nil)
  (win:startup-with-window)
  (win:startup-with-window))

(provide '99-misc)
;;; 99-misc.el ends here
