;;; package --- Summary
;;; Commentary:
;;; Code:

(autoload 'php-mode "php-mode" "PHP mode" t)

(add-hook 'php-mode-hook
          '(lambda()
             (php-set-style "php")
             ))

;;; 10-php.el ends here
