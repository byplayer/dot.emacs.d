(defun my-flycheck-c++-setup ()
  (setq flycheck-gcc-language-standard "c++11"))

(add-hook 'c++-mode-hook #'my-flycheck-c++-setup)

