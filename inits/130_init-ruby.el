;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-modeの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/ruby/")
(require 'rvm)

(add-to-list 'load-path "~/.emacs.d/elisp/ruby-mode/")

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

;; よくあるコードを、自動挿入する。
(require 'ruby-electric)

;; flymake-modeで補完する対象を追加
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
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-rails/")

(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
        try-complete-file-name
        try-expand-dabbrev))

(require 'rails)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cucumber.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/cucumber.el/")

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
;; rspec-modeの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/rspec-mode/")
(require 'rspec-mode)

;; (setq rails-use-mongrel t)
;; (define-key rails-minor-mode-map "\C-c\C-p" 'rails-lib:run-primary-switch)
;; (define-key rails-minor-mode-map "\C-c\C-n" 'rails-lib:run-secondary-switch)

;; ;; emacs -nwだと、キーバインドを変更しないと
;; ;; rails-goto-file-on-current-lineが動かない。
;; ;; http://d.hatena.ne.jp/kabus/20070822/1187806296
;; (define-key rails-minor-mode-map "\C-cj"    'rails-goto-file-on-current-line)

;; ;; emacs-railsで、C-c C-c C-tした時にtagsを作るファイルの置かれたディレクトリ
;; ;; http://d.hatena.ne.jp/Rommy/20070906/p1
;; (setq rails-tags-dirs '("app" "lib" "test" "db" "vendor"))
;; (setq rails-tags-command "ctags -e --Ruby-kinds=-f -o %s --exclude='*.html' -R %s")

;; ;; Emacs内からReFeのドキュメントを読む。M-x refeで実行。
;; ;; http://i.loveruby.net/ja/prog/refe.html
;; (require 'refe)

;; ;; Emacs内でautotest実行。M-x autotestで実行。
;; ;; http://www.emacswiki.org/cgi-bin/emacs/download/autotest.el
;; (require 'autotest)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ri
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/ri-emacs/")

(setq ri-ruby-script "~/.emacs.d/elisp/ri-emacs/ri-emacs.rb")
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
(add-to-list 'load-path "~/.emacs.d/elisp/ruby-block/")

(require 'ruby-block)
; (ruby-block-mode t)

; ;; 何もしない
; (setq ruby-block-highlight-toggle 'noghing)
;; ミニバッファに表示
; (setq ruby-block-highlight-toggle 'minibuffer)
;; オーバレイする
; (setq ruby-block-highlight-toggle 'overlay)
;; ミニバッファに表示し, かつ, オーバレイする.
; (setq ruby-block-highlight-toggle t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-mode用フック処理追加
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ruby-mode-hook()
  (define-key ruby-mode-map "\C-m" 'ruby-reindent-then-newline-and-indent)
  ; (pabbrev-mode t)
  (ruby-electric-mode t)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

