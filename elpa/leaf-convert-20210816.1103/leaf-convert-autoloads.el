;;; leaf-convert-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "leaf-convert" "leaf-convert.el" (0 0 0 0))
;;; Generated autoloads from leaf-convert.el

(autoload 'leaf-convert-insert-template "leaf-convert" "\
Insert template `leaf' block for PKG using package.el cache.
And kill generated leaf block to quick yank.

\(fn PKG)" t nil)

(autoload 'leaf-convert "leaf-convert" "\
Convert BODY as plain Elisp to leaf format.

\(fn &rest BODY)" nil t)

(autoload 'leaf-convert-region-replace "leaf-convert" "\
Replace Elisp BEG to END to leaf format.

This command support prefix argument.
  - With a normal, replace region with converted leaf form.
  - With a `\\[universal-argument]', insert converted leaf form after region.

\(fn BEG END)" t nil)

(autoload 'leaf-convert-region-pop "leaf-convert" "\
Pop a buffer showing the result of converting Elisp BEG to END to a leaf.

\(fn BEG END)" t nil)

(autoload 'leaf-convert-buffer-replace "leaf-convert" "\
Replace Elisp buffer to leaf form." t nil)

(autoload 'leaf-convert-buffer-pop "leaf-convert" "\
Pop converted leaf buffer from Elisp buffer." t nil)

(register-definition-prefixes "leaf-convert" '("leaf-convert-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; leaf-convert-autoloads.el ends here
