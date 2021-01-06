;;; package --- Summary
;;; Commentary:
;;; Code:

(leaf python
  :ensure t
  :mode (("\\.py$" . python-mode)))

(leaf py-autopep8
  :ensure t
  :commands (py-autopep8-before-save py-autopep8-enable-on-save)
  :hook (python-mode-hook . py-autopep8-enable-on-save))

(leaf jedi-core
  :ensure t
  :commands (jedi:start-dedicated-server
             helm-jedi-related-names
             jedi:setup
             jedi:install-server
             jedi:reinstall-server
             jedi:install-server-block)
  :init
  (setq jedi:environment-root "~/.virtualenvs/jedi"))

(leaf company-jedi
  :ensure t
  :init
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook))

(leaf virtualenvwrapper
  :ensure t
  :commands (venv-projectile-auto-workon
             venv-workon
             venv-mkvirtualenv-using
             venv-mkvirtualenv
             venv-rmvirtualenv
             venv-lsvirtualenv
             venv-cdvirtualenv
             venv-cpvirtualenv))
(leaf auto-virtualenvwrapper
  :ensure t
  :commands (auto-virtualenvwrapper-activate)
  :hook (python-mode-hook . auto-virtualenvwrapper-activate))

(provide '10-python)
;;; 10-python.el ends here
