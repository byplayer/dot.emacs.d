;;; phpunit-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from phpunit.el

(defvar-local phpunit-root-directory nil "\
Directory path to execute PHPUnit.")
(put 'phpunit-root-directory 'safe-local-variable #'stringp)
(defvar-local phpunit-args nil "\
Argument to pass to phpunit command.")
(put 'phpunit-args 'safe-local-variable #'(lambda (v) (or (stringp v) (listp v))))
(defvar-local phpunit-executable nil "\
PHPUnit command or path to executable file.")
(put 'phpunit-executable 'safe-local-variable #'(lambda (v) (or (null v) (stringp v) (functionp v))))
(autoload 'phpunit-set-dir-local-variable "phpunit" "\
Create project file `.dir-locals.el' and set `VARIABLE' for `phpunit.el'.

(fn VARIABLE)" t)
(autoload 'phpunit-current-test "phpunit" "\
Launch PHPUnit on curent test." t)
(autoload 'phpunit-current-class "phpunit" "\
Launch PHPUnit on current class." t)
(autoload 'phpunit-current-project "phpunit" "\
Launch PHPUnit on current project." t)
(autoload 'phpunit-group "phpunit" "\
Launch PHPUnit for group.

(fn USE-LAST-GROUP &optional GROUP)" t)
(register-definition-prefixes "phpunit" '("php"))


;;; Generated autoloads from phpunit-mode.el

(register-definition-prefixes "phpunit-mode" '("phpunit-mode"))

;;; End of scraped data

(provide 'phpunit-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; phpunit-autoloads.el ends here
