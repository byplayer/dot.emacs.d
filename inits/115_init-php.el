;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; configuration for php
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/php-mode/")

(autoload 'php-mode "php-mode" "PHP mode" t)

(defcustom php-file-patterns (list "\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'")
  "*List of file patterns for which to automatically invoke php-mode."
  :type '(repeat (regexp :tag "Pattern"))
  :group 'php)

(let ((php-file-patterns-temp php-file-patterns))
  (while php-file-patterns-temp
    (add-to-list 'auto-mode-alist
                 (cons (car php-file-patterns-temp) 'php-mode))
    (setq php-file-patterns-temp (cdr php-file-patterns-temp))))

(defun my-php-mode-hook()
  (gtags-mode 1))

(add-hook 'php-mode-hook 'my-php-mode-hook)