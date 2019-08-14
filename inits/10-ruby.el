;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'ruby-mode)

(use-package rubocopfmt
  :commands (rubocopfmt-mode)
  :init
  (setq rubocopfmt-rubocop-command "rubocop-daemon-wrapper"))

(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

(add-hook 'ruby-mode-hook
          '(lambda()
             (robe-mode)
             (add-to-list (make-local-variable 'company-backends) '(company-robe :with company-yasnippet))
             ))
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)

(add-hook 'robe-mode-hook
          '(lambda()
             (define-key robe-mode-map (kbd "M-.") 'helm-gtags-find-tag)
             (define-key robe-mode-map (kbd "M-,") 'helm-gtags-find-rtag)
             (define-key robe-mode-map (kbd "M-/") 'helm-gtags-find-pattern)
             (define-key robe-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
             (define-key robe-mode-map (kbd "M-*") 'helm-gtags-pop-stack)
             ))

(setq auto-mode-alist
      (append '(
                ("\\.rb$" . ruby-mode)
                ("Rakefile" . ruby-mode)
                ("Gemfile" . ruby-mode)
                ("\\.rjs" . ruby-mode)
                ("\\.rake" . ruby-mode)
                ) auto-mode-alist))

(setq interpreter-mode-alist
      (append '(
                ("ruby" . ruby-mode)
                )
              interpreter-mode-alist))

;; flymake-modeで補完する対象を追加
; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
; (push '(".+\\.rjs$" flymake-ruby-init) flymake-allowed-file-name-masks)

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (inf-ruby-keys)
;;              (abbrev-mode nil)
;;              (flymake-mode t)))

;; rinari
;; https://github.com/eschulte/rinari
(require 'rinari)

(setq auto-mode-alist
      (append '(
                ("\\.rxml$" . web-mode)
                ("\\.erb$". web-mode)
                ("\\.rhtml$". web-mode)
                ) auto-mode-alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; feature-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;(setq feature-default-language "fi")
;; ;; point to cucumber languages.yml or gherkin i18n.yml to use
;; ;; exactly the same localization your cucumber uses
;; ;(setq feature-default-i18n-file "/path/to/gherkin/gem/i18n.yml")
;; ;; and load feature-mode
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

; bind return to newline-and-indent
(defun my-feature-mode-hook()
  (define-key feature-mode-map "\C-m" 'newline-and-indent)
  (rinari-launch))

(add-hook 'feature-mode-hook 'my-feature-mode-hook)

;; set rspec-mode like key map
(define-key feature-mode-map  (kbd "C-c ,a") 'feature-verify-all-scenarios-in-project)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rspec-modeの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rspec-mode)
(add-hook 'rspec-mode-hook
          '(lambda ()
             (setq yas/mode-symbol 'rspec-mode)))

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
;; ruby-block
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ruby-block)
(ruby-block-mode t)

; ;; 何もしない
; (setq ruby-block-highlight-toggle 'noghing)
;; ミニバッファに表示
(setq ruby-block-highlight-toggle 'minibuffer)
;; オーバレイする
; (setq ruby-block-highlight-toggle 'overlay)
;; ミニバッファに表示し, かつ, オーバレイする.
; (setq ruby-block-highlight-toggle t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-mode用フック処理追加
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ruby-mode-hook()
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)
  (local-set-key [f1] 'ri)
  (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
  (local-set-key [f4] 'ri-ruby-show-args)
  ;; modify : as punctuation character
  ;; helm-gtags can't jump ModuleName::Class string,
  ;; so change ruby-mode-syntax-table, and select only
  ;; class name if I use M-. .
  (modify-syntax-entry ?: "." ruby-mode-syntax-table)
  ;; add following characters into syntax
  (modify-syntax-entry ?@ "_" ruby-mode-syntax-table)
  (modify-syntax-entry ?! "_" ruby-mode-syntax-table)
  (flyspell-prog-mode)
  (rubocopfmt-mode))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

(define-key ruby-mode-map [return] 'newline-and-indent)

;; rabbit
(use-package rd-mode
  :quelpa (rd-mode :fetcher github :repo "byplayer/rd-mode")
  :ensure t)
(use-package rabbit-mode
  :quelpa (rabbit-mode :fetcher github :repo "byplayer/rabbit-mode")
  :ensure t
  :mode (("\\.rbt$" . rabbit-mode)
         ("\\.rab$" . rabbit-mode)))

;; disable to insert magic comment
(setq ruby-insert-encoding-magic-comment nil)

;; rubocop
(setq rubocopfmt-use-bundler-when-possible nil)

(provide '10-ruby)
;;; 10-ruby.el ends here
