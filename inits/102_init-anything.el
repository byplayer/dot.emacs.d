;; configuration for anything
;; install: auto-install-batch RET anything RET
(require 'anything)

(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

;;; anything-match-plugin.el extends pattern matching. Some Anything
;;; Applications requires it. It is a must-have plugin now.
;;;
(require 'anything-match-plugin)

;;; anything-complete.el replaces various completion with anything
;;; (like Icicles). Use Anything power for normal completion.
(when (require 'anything-complete nil t)
  ;; Automatically collect symbols by 150 secs
  (anything-lisp-complete-symbol-set-timer 150)
  (define-key emacs-lisp-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
  (define-key lisp-interaction-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
  ;; Comment if you do not want to replace completion commands with `anything'.
  (anything-read-string-mode 1)
  )

;;; anything-show-completion.el shows current selection prettily.
(require 'anything-show-completion)

;;; anything-auto-install.el integrates auto-install.el with anything.
(require 'anything-auto-install nil t)

;;; descbinds-anything.el replaces describe-bindings with anything interface.
(when (require 'descbinds-anything nil t)
  ;; Comment if you do not want to replace `describe-bindings' with `anything'.
  (descbinds-anything-install)
  )

;;; `anything-grep' replaces standard `grep' command.
(require 'anything-grep nil t)

(provide 'anything-startup)

(setq anything-sources
      (list anything-c-source-buffers-list
            anything-c-source-bookmarks
            anything-c-source-files-in-current-dir+
            anything-c-source-recentf
            anything-c-source-man-pages
            anything-c-source-info-pages
            anything-c-source-calculation-result
            anything-c-source-locate
            anything-c-source-emacs-commands))

(setq anything-for-files-prefered-list
      (list anything-c-source-buffers-list
            anything-c-source-ffap-line
            anything-c-source-ffap-guesser
            anything-c-source-bookmarks
            anything-c-source-files-in-current-dir+
            anything-c-source-recentf
            anything-c-source-locate
            anything-c-source-file-cache))

(setq anything-find-file-additional-sources
      (list anything-c-source-locate))

(define-key global-map (kbd "C-;") 'anything)

;; add anything-gtags
(require 'anything-gtags)

(define-key global-map (kbd "C-x b") 'anything-for-files)
(define-key global-map (kbd "C-x C-f") 'anything-find-file)