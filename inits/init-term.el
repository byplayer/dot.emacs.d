;; setup multi-term
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/term/") load-path))

(require 'multi-term)
(setq multi-term-program shell-file-name)

;; set unbind key for term
(add-to-list 'term-unbind-key-list '"C-r")

;; setup ansi-color
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


(add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-filter-hook
          '(lambda ()
             (let ((start-marker (make-marker))
                   (end-marker (process-mark (get-buffer-process (current-buffer)))))
               (set-marker start-marker (point-min))
               (ansi-color-apply-on-region start-marker end-marker))))

(require 'shell)

(set-face-foreground 'comint-highlight-prompt "LightSkyBlue")
(set-face-bold-p 'comint-highlight-input nil)

;; stop echo
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

;; shell-modeでは画面端で折り返す
(add-hook 'shell-mode-hook
          (lambda ()
            (custom-set-variables
             '(truncate-lines nil)
             '(truncate-partial-width-windows nil))))

;; set term color
(custom-set-variables
     '(term-default-bg-color "#000000")        ;; background color (black)
     '(term-default-fg-color "light gray"))    ;; foreground color (light gray)

