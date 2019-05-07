;;; package --- Summary
;;; Commentary:
;;; Code:

(defun java-compile ()
  "Traveling up the path, find build.xml file and run compile."
  (interactive)
  (save-buffer)
  (with-temp-buffer
    (while (and (not (or (file-exists-p "build.xml")
                         (file-exists-p "pom.xml")
                         (file-exists-p "build.gradle")))
        (not (equal "/" default-directory)))
      (cd ".."))
    (call-interactively 'compile)))
    ;; (set (make-local-variable 'compile-command)
    ;;  (if (file-exists-p "build.xml")
    ;;      "ant -emacs"
    ;;    (if (file-exists-p "build.gradle")
    ;;        "gradle build"
    ;;        "mvn compile")))
    ;; (call-interactively 'compile)))

(add-hook 'java-mode-hook
          (lambda ()
            (google-set-c-style)
            (google-make-newline-indent)
            (setq c-basic-offset 2)
            (setq tab-width 2)
            (setq indent-tabs-mode nil)
            (define-key java-mode-map (kbd "C-c c") 'java-compile)))

(add-to-list 'auto-mode-alist '("\\.gradle$"     . groovy-mode))

;; google-java-format
(setq google-java-format-executable "/opt/google-java-format/bin/google-java-format")

;; google-java-format-buffer
(defun my-java-before-save ()
  "Usage: (add-hook 'before-save-hook #'my-java-before-save)"

  (interactive)
  (if (eq major-mode 'java-mode) (google-java-format-buffer)))
(add-hook 'before-save-hook #'my-java-before-save)


(provide '10-java)
;;; 10-java.el ends here
