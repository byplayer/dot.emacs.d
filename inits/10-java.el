;;; package --- Summary
;;; Commentary:
;;; Code:

(defun ant-compile ()
  "Traveling up the path, find build.xml file and run compile."
  (interactive)
  (save-buffer)
  (with-temp-buffer
    (while (and (not (file-exists-p "build.xml"))
        (not (equal "/" default-directory)))
      (cd ".."))
    (set (make-local-variable 'compile-command)
     "ant -emacs")
    (call-interactively 'compile)))

(add-hook 'java-mode-hook
          (lambda ()
            (c-set-style "java")
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 4)
            (define-key java-mode-map (kbd "C-c c") 'ant-compile)))

(provide '10-java)
;;; 10-java.el ends here
