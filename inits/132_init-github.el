;; gist
;; If you want to use gist.el, set following git config 
;; github.user=????
;; github.token=????
(add-to-list 'load-path "~/.emacs.d/elisp/gist.el/")

;; M-x anything-c-source-gist
(add-to-list 'load-path "~/.emacs.d/elisp/anything-gist.el/")

(require 'anything-gist)
