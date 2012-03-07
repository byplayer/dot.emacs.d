(add-to-list 'load-path "/usr/local/global/share/gtags/")
(require 'gtags)

;; fix buf of 6.2.1
;; I think this patch only 6.2.1...
(defun gtags-select-it (delete &optional other-win)
  (let (line file)
    ;; get context from current tag line
    (beginning-of-line)
    (if (not (looking-at "[^ \t]+[ \t]+\\([0-9]+\\)[ \t]\\([^ \t]+\\)[ \t]"))
        (gtags-pop-context)
      (setq line (string-to-number (gtags-match-string 1)))
      (setq file (gtags-decode-pathname (gtags-match-string 2)))
      (let (rootdir)
          (if gtags-rootdir
            (setq rootdir gtags-rootdir)
           (setq rootdir (gtags-get-rootpath)))
          (if rootdir (setq file (concat rootdir file))))
      ;;
      ;; Why should we load new file before killing current-buffer?
      ;;
      ;; If you kill current-buffer before loading new file, current directory
      ;; will be changed. This might cause loading error, if you use relative
      ;; path in [GTAGS SELECT MODE], because emacs's buffer has its own
      ;; current directory.
      ;;
      (let ((prev-buffer (current-buffer)))
        ;; move to the context
        (if gtags-read-only
            (if (null other-win) (find-file-read-only file)
              (find-file-read-only-other-window file))
          (if (null other-win) (find-file file)
            (find-file-other-window file)))
        (if delete (kill-buffer prev-buffer)))
      (setq gtags-current-buffer (current-buffer))
      (goto-line line)
      (gtags-mode 1))))

(define-key gtags-mode-map "\M-." 'gtags-find-tag)
(define-key gtags-mode-map "\M-," 'gtags-find-rtag)
(define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
(define-key gtags-mode-map "\M-/" 'gtags-find-pattern)
(define-key gtags-mode-map "\M-*" 'gtags-pop-stack)

;; change synbol regexp for finding emacs function
(setq gtags-symbol-regexp "[A-Za-z_][A-Za-z_0-9---\?]*")

