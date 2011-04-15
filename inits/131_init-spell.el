;; set command
(setq ispell-program-name "aspell")     ;use aspell insted of ispell
(setq ispell-grep-command "grep")       ;use grep insted of egrep

;; check English word in Japanese document .
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]")))
