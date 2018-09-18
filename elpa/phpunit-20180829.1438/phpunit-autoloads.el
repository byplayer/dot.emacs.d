;;; phpunit-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "phpunit" "phpunit.el" (23456 24871 307158
;;;;;;  471000))
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

\(fn VARIABLE)" t nil)

(autoload 'phpunit-current-test "phpunit" "\
Launch PHPUnit on curent test.

\(fn)" t nil)

(autoload 'phpunit-current-class "phpunit" "\
Launch PHPUnit on current class.

\(fn)" t nil)

(autoload 'phpunit-current-project "phpunit" "\
Launch PHPUnit on current project.

\(fn)" t nil)

(autoload 'phpunit-group "phpunit" "\
Launch PHPUnit for group.

\(fn USE-LAST-GROUP &optional GROUP)" t nil)

;;;***

;;;### (autoloads nil nil ("phpunit-mode.el" "phpunit-pkg.el") (23456
;;;;;;  24871 303156 472000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; phpunit-autoloads.el ends here
