(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/egg/") load-path))

(require 'egg)
(setq exec-path
        (append
            (list "/usr/local/git/bin")exec-path))
