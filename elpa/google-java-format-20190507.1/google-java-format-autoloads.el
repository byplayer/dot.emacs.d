;;; google-java-format-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "google-java-format" "google-java-format.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from google-java-format.el

(autoload 'google-java-format-region "google-java-format" "\
Use google-java-format to format the code between START and END.
If called interactively, uses the region, if there is one.  If
there is no region, then formats the current line.

\(fn START END)" t nil)

(autoload 'google-java-format-buffer "google-java-format" "\
Use google-java-format to format the current buffer.

\(fn)" t nil)

(defalias 'google-java-format 'google-java-format-region)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "google-java-format" '("google-java-format-executable")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; google-java-format-autoloads.el ends here
