(defun my-lisp-pair-insert-hook()
  (make-variable-buffer-local 'skeleton-pair)
  (make-variable-buffer-local 'skeleton-pair-on-word)
  (setq skeleton-pair-on-word t)
  (setq skeleton-pair t)
  (make-variable-buffer-local 'skeleton-pair-alist)
  (gtags-mode 1)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe))

(add-hook 'emacs-lisp-mode-hook
          '(lambda()
             (progn
               (my-lisp-pair-insert-hook)
               (setq indent-tabs-mode nil))))

(add-hook 'lisp-mode-hook
          '(lambda()
             (progn
               (my-lisp-pair-insert-hook)
               (setq indent-tabs-mode nil))))
