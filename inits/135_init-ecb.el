;; for ECB
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "light gray")
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


(add-to-list 'load-path "~/.emacs.d/elisp/ecb-2.40")

(setq semantic-load-turn-useful-things-on t)
(require 'ecb)

;; custom layout
(ecb-layout-define "method-analyse" left nil
  (dotimes (i 2) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (if (fboundp (quote ecb-set-methods-buffer)) (ecb-set-methods-buffer) (ecb-set-default-ecb-buffer))
  (ecb-split-ver 0.8 t)
  (dotimes (i 1) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (if (fboundp (quote ecb-set-analyse-buffer)) (ecb-set-analyse-buffer) (ecb-set-default-ecb-buffer))
  )

(setq ecb-windows-width 0.25)
(defun ecb-toggle ()
  (interactive)
  (if ecb-minor-mode
      (ecb-deactivate)
    (progn
      (ecb-activate)
      (ecb-layout-switch "method-analyse")
      )))
