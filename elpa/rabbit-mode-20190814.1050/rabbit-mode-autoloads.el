;;; rabbit-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rabbit-mode" "rabbit-mode.el" (0 0 0 0))
;;; Generated autoloads from rabbit-mode.el

(add-to-list 'auto-mode-alist '("\\.rab\\'" . rabbit-mode))

(autoload 'rabbit-mode "rabbit-mode" "\
Major mode for editing Rabbit slide in RD.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rabbit-mode" '("rabbit-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rabbit-mode-autoloads.el ends here
