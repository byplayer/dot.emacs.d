;;; leaf-keywords-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "leaf-keywords" "leaf-keywords.el" (0 0 0 0))
;;; Generated autoloads from leaf-keywords.el

(autoload 'leaf-key-chord "leaf-keywords" "\
Bind CHORD to COMMAND in KEYMAP (`global-map' if not passed).

CHORD must be 2 length of string
COMMAND must be an interactive function or lambda form.

KEYMAP, if present, should be a keymap and not a quoted symbol.
For example:
  (leaf-key-chord \"jk\" 'undo 'c-mode-map)

\(fn CHORD COMMAND &optional KEYMAP)" nil t)

(autoload 'leaf-key-chords "leaf-keywords" "\
Bind multiple BIND for KEYMAP defined in PKG.
BIND is (KEY . COMMAND) or (KEY . nil) to unbind KEY.
This macro is minor change version form `leaf-keys'.

OPTIONAL:
  BIND also accept below form.
    (:{{map}} :package {{pkg}} (KEY . COMMAND) (KEY . COMMAND))
  KEYMAP is quoted keymap name.
  PKG is quoted package name which define KEYMAP.
  (wrap `eval-after-load' PKG)

  If DRYRUN-NAME is non-nil, return list like
  (LEAF_KEYS-FORMS (FN FN ...))

  If omit :package of BIND, fill it in LEAF_KEYS-FORM.

NOTE: BIND can also accept list of these.

\(fn BIND &optional DRYRUN-NAME)" nil t)

(autoload 'leaf-key-chords* "leaf-keywords" "\
Similar to `leaf-key-chords', but overrides any mode-specific bindings for BIND.

\(fn BIND)" nil t)

(autoload 'leaf-keywords-init "leaf-keywords" "\
Add additional keywords to `leaf'.
If RENEW is non-nil, renew leaf-{keywords, normalize} cache.

\(fn &optional RENEW)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "leaf-keywords" '("leaf-")))

;;;***

;;;### (autoloads nil nil ("leaf-keywords-defaults.el" "leaf-keywords-pkg.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; leaf-keywords-autoloads.el ends here
