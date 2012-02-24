(setq ruby-command "ruby.exe")

(setq default-file-name-coding-system 'japanese-shift-jis-dos)

(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 3)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                                 ; ~/.emacs.d/server is unsafe"
                                                 ; on windows.
