;;; blackout-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "blackout" "blackout.el" (0 0 0 0))
;;; Generated autoloads from blackout.el

(autoload 'blackout "blackout" "\
Do not display MODE in the mode line.
If REPLACEMENT is given, then display it instead. REPLACEMENT may
be a string or more generally any mode line construct (see
`mode-line-format').

\(fn MODE &optional REPLACEMENT)" nil nil)

(autoload 'use-package-normalize/:blackout "blackout" "\
Normalize the arguments to `:blackout'.
The return value is an alist whose cars are mode names and whose
cdrs are mode line constructs. For documentation on NAME,
KEYWORD, and ARGS, refer to `use-package'.

\(fn NAME KEYWORD ARGS)" nil nil)

(autoload 'use-package-handler/:blackout "blackout" "\
Handle `:blackout' keyword.
For documentation on NAME, KEYWORD, ARG, REST, and STATE, refer
to `use-package'.

\(fn NAME KEYWORD ARG REST STATE)" nil nil)

(with-eval-after-load 'use-package-core (when (and (boundp 'use-package-keywords) (listp use-package-keywords)) (add-to-list 'use-package-keywords :blackout 'append)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "blackout" '("blackout-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; blackout-autoloads.el ends here
