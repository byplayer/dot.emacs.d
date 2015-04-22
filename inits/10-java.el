;;; package --- Summary
;;; Commentary:
;;; Code:

(defun java-compile ()
  "Traveling up the path, find build.xml file and run compile."
  (interactive)
  (save-buffer)
  (with-temp-buffer
    (while (and (not (or (file-exists-p "build.xml")
                         (file-exists-p "pom.xml")))
        (not (equal "/" default-directory)))
      (cd ".."))
    (set (make-local-variable 'compile-command)
     (if (file-exists-p "build.xml") "ant -emacs" "mvn compile"))
    (call-interactively 'compile)))

(add-hook 'java-mode-hook
          (lambda ()
            (c-set-style "java")
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 4)
            (define-key java-mode-map (kbd "C-c c") 'java-compile)))

(provide '10-java)
;;; 10-java.el ends here
