(set-language-environment "Japanese")
(setq default-input-method "W32-IME")
(w32-ime-initialize)
(setq w32-ime-buffer-switch-p nil)
(setq-default w32-ime-mode-line-state-indicator "[--]")
(setq w32-ime-mode-line-state-indicator-list '("[--]" "[‚ ]" "[--]"))
(add-hook 'input-method-activate-hook
          (lambda() (set-cursor-color "SteelBlue")))
(add-hook 'input-method-inactivate-hook
          (lambda() (set-cursor-color "gray")))

; ime off when ask yes/no
(wrap-function-to-control-ime 'universal-argument t nil)
(wrap-function-to-control-ime 'read-string nil nil)
(wrap-function-to-control-ime 'read-char nil nil)
(wrap-function-to-control-ime 'read-from-minibuffer nil nil)
(wrap-function-to-control-ime 'y-or-n-p nil nil)
(wrap-function-to-control-ime 'yes-or-no-p nil nil)
(wrap-function-to-control-ime 'map-y-or-n-p nil nil)