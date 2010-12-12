;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-mode$B$N@_Dj(B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/ruby/")
(require 'rvm)

(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/ruby-mode/") load-path))

(require 'ruby-mode)
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

(setq auto-mode-alist
      (append '(
                ("\\.rb$" . ruby-mode)
                ("Rakefile" . ruby-mode)
                ("\\.rjs" . ruby-mode)
                ) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.rhtml" . rhtml-mode) auto-mode-alist))

(setq interpreter-mode-alist
      (append '(
                ("ruby" . ruby-mode)
                )
              interpreter-mode-alist))

;; $B$h$/$"$k%3!<%I$r!"<+F0A^F~$9$k!#(B
(require 'ruby-electric)

;; flymake-mode$B$GJd40$9$kBP>]$rDI2C(B
; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
; (push '(".+\\.rjs$" flymake-ruby-init) flymake-allowed-file-name-masks)

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (inf-ruby-keys)
;;              (ruby-electric-mode t)
;;              (abbrev-mode nil)
;;              (flymake-mode t)))

;; rails
;; http://d.hatena.ne.jp/higepon/20061222/1166774270
(setq load-path
       (cons (expand-file-name "~/.emacs.d/elisp/emacs-rails/") load-path))

(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
        try-complete-file-name
        try-expand-dabbrev))
(setq rails-use-mongrel t)

(require 'rails)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cucumber.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/cucumber.el/") load-path))

;; ;(setq feature-default-language "fi")
;; ;; point to cucumber languages.yml or gherkin i18n.yml to use
;; ;; exactly the same localization your cucumber uses
;; ;(setq feature-default-i18n-file "/path/to/gherkin/gem/i18n.yml")
;; ;; and load feature-mode
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

; bind return to newline-and-indent
(defun my-feature-mode-hook()
  (define-key feature-mode-map "\C-m" 'newline-and-indent))
(add-hook 'feature-mode-hook 'my-feature-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rspec-mode$B$N@_Dj(B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/rspec-mode/") load-path))
(require 'rspec-mode)

;; (setq rails-use-mongrel t)
;; (define-key rails-minor-mode-map "\C-c\C-p" 'rails-lib:run-primary-switch)
;; (define-key rails-minor-mode-map "\C-c\C-n" 'rails-lib:run-secondary-switch)

;; ;; emacs -nw$B$@$H!"%-!<%P%$%s%I$rJQ99$7$J$$$H(B
;; ;; rails-goto-file-on-current-line$B$,F0$+$J$$!#(B
;; ;; http://d.hatena.ne.jp/kabus/20070822/1187806296
;; (define-key rails-minor-mode-map "\C-cj"    'rails-goto-file-on-current-line)

;; ;; emacs-rails$B$G!"(BC-c C-c C-t$B$7$?;~$K(Btags$B$r:n$k%U%!%$%k$NCV$+$l$?%G%#%l%/%H%j(B
;; ;; http://d.hatena.ne.jp/Rommy/20070906/p1
;; (setq rails-tags-dirs '("app" "lib" "test" "db" "vendor"))
;; (setq rails-tags-command "ctags -e --Ruby-kinds=-f -o %s --exclude='*.html' -R %s")

;; ;; Emacs$BFb$+$i(BReFe$B$N%I%-%e%a%s%H$rFI$`!#(BM-x refe$B$G<B9T!#(B
;; ;; http://i.loveruby.net/ja/prog/refe.html
;; (require 'refe)

;; ;; Emacs$BFb$G(Bautotest$B<B9T!#(BM-x autotest$B$G<B9T!#(B
;; ;; http://www.emacswiki.org/cgi-bin/emacs/download/autotest.el
;; (require 'autotest)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ri
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/ri-emacs/") load-path))

(setq ri-ruby-script "C:/Gotou/home/.emacs.d/elisp/ri-emacs/ri-emacs.rb")
(autoload 'ri "ri-ruby.el" nil t)

(add-hook 'ruby-mode-hook (lambda ()
                            (local-set-key [f1] 'ri)
                            (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
                            (local-set-key [f4] 'ri-ruby-show-args)
                            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; refe
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'refe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-block
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elisp/ruby-block/") load-path))

(require 'ruby-block)
; (ruby-block-mode t)

; ;; $B2?$b$7$J$$(B
; (setq ruby-block-highlight-toggle 'noghing)
;; $B%_%K%P%C%U%!$KI=<((B
; (setq ruby-block-highlight-toggle 'minibuffer)
;; $B%*!<%P%l%$$9$k(B
; (setq ruby-block-highlight-toggle 'overlay)
;; $B%_%K%P%C%U%!$KI=<($7(B, $B$+$D(B, $B%*!<%P%l%$$9$k(B.
; (setq ruby-block-highlight-toggle t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-mode$BMQ%U%C%/=hM}DI2C(B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ruby-mode-hook()
  (define-key ruby-mode-map "\C-m" 'ruby-reindent-then-newline-and-indent)
  ; (pabbrev-mode t)
  (ruby-electric-mode t)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

; ruby-electric.el$B$H(Banty.el$B$N6%9g2sHr(B
(let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
  (setq minor-mode-map-alist (append (delete rel minor-mode-map-alist) (list rel))))

