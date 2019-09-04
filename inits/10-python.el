;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package python
  :ensure t
  :mode (("\\.py$" . python-mode)))

(use-package py-autopep8
  :ensure t
  :commands (py-autopep8-before-save py-autopep8-enable-on-save)
  :init
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))

(use-package virtualenvwrapper
  :commands (venv-projectile-auto-workon
             venv-workon
             venv-mkvirtualenv-using
             venv-mkvirtualenv
             venv-rmvirtualenv
             venv-lsvirtualenv
             venv-cdvirtualenv
             venv-cpvirtualenv))

(provide '10-python)
;;; 10-python.el ends here
