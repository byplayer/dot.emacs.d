;;; windows-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "revive" "revive.el" (0 0 0 0))
;;; Generated autoloads from revive.el

(autoload 'current-window-configuration-printable "revive" "\
Return the printable current-window-configuration.
This configuration will be stored by restore-window-configuration.
Returned configurations are list of:
'(Screen-Width Screen-Height Edge-List Buffer-List)

Edge-List is a return value of revive:all-window-edges, list of all
window-edges whose first member is always of north west window.

Buffer-List is a list of buffer property list of all windows.  This
property lists are stored in order corresponding to Edge-List.  Buffer
property list is formed as
'((buffer-file-name) (buffer-name) (point) (window-start))." nil nil)

(autoload 'restore-window-configuration "revive" "\
Restore the window configuration.
Configuration CONFIG should be created by
current-window-configuration-printable.

\(fn CONFIG)" nil nil)

(autoload 'wipe "revive" "\
Wipe Emacs." t nil)

(autoload 'save-current-configuration "revive" "\
Save current window/buffer configuration into configuration file.

\(fn &optional NUM)" t nil)

(autoload 'resume "revive" "\
Resume window/buffer configuration.
Configuration should be saved by save-current-configuration.

\(fn &optional NUM)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "revive" '("construct-window-configuration" "resume-hook" "revive:")))

;;;***

;;;### (autoloads nil "windows" "windows.el" (0 0 0 0))
;;; Generated autoloads from windows.el

(autoload 'win-switch-to-window "windows" "\
Switch window configurations to a buffer specified by keyboard.
If calling from program, optional second argument WINDOW can specify
the window number.

\(fn ARG &optional WINDOW)" t nil)

(autoload 'win:set-wc "windows" "\
(Windows low level internal) Set the NUM-th windows configuration.
If Windows uses frame(Emacs 19), Select the NUM-th window frame.

\(fn NUM)" nil nil)

(autoload 'win:startup-with-window "windows" "\
Start up Emacs with window[1] selected." nil nil)

(autoload 'win-save-all-configurations "windows" "\
Save all window configurations into the configuration file." t nil)

(autoload 'wipe-windows "windows" "\
Kill all buffers.  Optional argument NO-ASK non-nil skips query.

\(fn &optional NO-ASK)" t nil)

(autoload 'win-load-all-configurations "windows" "\
Load all window configurations from the configuration file.
Non-nil for optional argument PRESERVE keeps all current buffers.

\(fn &optional PRESERVE)" t nil)

(autoload 'see-you-again "windows" "\
Save all of the window configurations and kill-emacs." t nil)

(autoload 'resume-windows "windows" "\
Restore all window configurations reading configurations from a file.
Non-nil for optional argument PRESERVE keeps current buffers.

\(fn &optional PRESERVE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "windows" '("win")))

;;;***

;;;### (autoloads nil nil ("windows-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; windows-autoloads.el ends here
