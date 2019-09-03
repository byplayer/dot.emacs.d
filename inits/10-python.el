;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package python
  :ensure t
  :mode (("\\.py$" . python-mode)))

(use-package elpy
  :ensure t
  :init
  (setq elpy-rpc-backend "jedi")
  (elpy-enable))

(use-package py-autopep8
  :ensure t
  :commands py-autopep8-before-save
  :init
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))

(provide '10-python)
;;; 10-python.el ends here
