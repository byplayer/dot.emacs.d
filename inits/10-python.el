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

(use-package jedi-core
  :ensure t
  :commands (jedi:start-dedicated-server
             helm-jedi-related-names
             jedi:setup
             jedi:install-server
             jedi:reinstall-server
             jedi:install-server-block)
  :init
  (setq jedi:environment-root "~/.python_tool")
  (setq python-environment-directory "python_tool"))

(use-package company-jedi
  :ensure t
  :init
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook))

(use-package virtualenvwrapper
  :ensure t
  :commands (venv-projectile-auto-workon
             venv-workon
             venv-mkvirtualenv-using
             venv-mkvirtualenv
             venv-rmvirtualenv
             venv-lsvirtualenv
             venv-cdvirtualenv
             venv-cpvirtualenv))
(use-package auto-virtualenvwrapper
  :ensure t
  :commands (auto-virtualenvwrapper-activate)
  :init
  (add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate))

(provide '10-python)
;;; 10-python.el ends here
