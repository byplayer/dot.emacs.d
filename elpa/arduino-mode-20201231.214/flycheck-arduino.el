;;; flycheck-arduino.el --- Arduino support for flycheck.

;;; Commentary:



;;; Code:

(require 'flycheck)

(defvar flycheck-arduino-board nil
  "The Arduino board to be used for debugging Sketch.")

(flycheck-define-checker arduino
  "Arduino checker using Arduino IDE. (This requires higher than version 1.5+).
See `https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc'."
  ;; source, source-inplace, source-original
  :command ("arduino" "--verify" source)
  ;; :command `("arduino-cli" "debug" "-b" ,flycheck-arduino-board ,(projectile-project-root))
  :error-patterns
  (;; I don't make sure about this warning... How to emit a warning?
   (warning line-start (file-name) ":" line ":" column ": warning: " (message) line-end)
   (error   line-start (file-name) ":" line ":" column ": " (0+ "fatal ") "error: " (message) line-end))
  :modes (arduino-mode))

;;;###autoload
(defun flycheck-arduino-setup ()
  "Setup Flycheck Arduino.
Add `arduino' to `flycheck-checkers'."
  (interactive)
  (add-to-list 'flycheck-checkers 'arduino))



(provide 'flycheck-arduino)

;;; flycheck-arduino.el ends here
