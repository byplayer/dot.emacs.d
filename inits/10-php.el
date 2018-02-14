;;; package --- Summary
;;; Commentary:
;;; Code:

(autoload 'php-mode "php-mode" "PHP mode" t)

(add-hook 'php-mode-hook
          '(lambda()
             (php-set-style "php")
             (define-key php-mode-map (kbd "C-c , s") 'phpunit-current-test)
             (define-key php-mode-map (kbd "C-c , v") 'phpunit-current-class)
             (define-key php-mode-map (kbd "C-c , a") 'phpunit-current-project)
             ))
;;; 10-php.el ends here
