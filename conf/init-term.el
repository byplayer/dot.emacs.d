(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/term/") load-path))

(require 'multi-term)
(setq multi-term-program shell-file-name)
