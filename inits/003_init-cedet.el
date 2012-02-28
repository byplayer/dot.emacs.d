(add-to-list 'load-path "~/.emacs.d/elisp/cedet-1.0.1")
(load-file "~/.emacs.d/elisp/cedet-1.0.1/common/cedet.el")

(global-ede-mode t)
(semantic-load-enable-minimum-features)
;; Increase the delay before activation
(setq semantic-idle-scheduler-idle-time 10)

(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb/")

;;working with tags
;; gnu global support
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)
;; (semanticdb-enable-gnu-global-databases 'ruby-mode)

;; ctags
(require 'semanticdb-ectag)
(semantic-load-enable-primary-exuberent-ctags-support)

; (semantic-ectag-add-language-support ruby-mode "ruby" "ruby")
; (add-hook 'ruby-mode-hook 'semantic-ectag-simple-setup)
