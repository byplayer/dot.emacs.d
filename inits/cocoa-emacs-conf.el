;;; package --- Summary
;;; Commentary:
;;; Code:

(set-face-attribute 'default nil :family "Source Han Code JP M" :height 120)
(set-frame-font "Source Han Code JP M")

(setq ndeb-program-name "/opt/eblook/bin/eblook")

;; use option as meta also
(setq mac-option-modifier 'meta)

;; for C-x/M-x with FEP issue on Mac
(mac-auto-ascii-mode 1)

;; google Japanese input "com.google.inputmethod.Japanese.base"
;; Atok com.justsystems.inputmethod.atok32.Japanese
(defvar jp-input-source "com.justsystems.inputmethod.atok32.Japanese")

(defvar mac-win-last-ime-status 'off) ;; {'off|'on}
(defun mac-win-save-last-ime-status ()
  (setq mac-win-last-ime-status
        (if (string-match "\\.\\(Roman\\|US\\|ABC\\)$" (mac-input-source))
            'off 'on)))

(defun mac-win-restore-ime ()
  (when (and mac-auto-ascii-mode (eq mac-win-last-ime-status 'on))
    (mac-select-input-source jp-input-source)))

(defun advice:mac-auto-ascii-setup-input-source (&optional _prompt)
  "Extension to store IME status"
  (mac-win-save-last-ime-status))
(advice-add 'mac-auto-ascii-setup-input-source :before
            #'advice:mac-auto-ascii-setup-input-source)

(defun mac-win-restore-ime-target-commands ()
  (when (and mac-auto-ascii-mode
             (eq mac-win-last-ime-status 'on))
    (mapc (lambda (command)
            (when (string-match
                   (format "^%s" command) (format "%s" this-command))
              (mac-select-input-source jp-input-source)))
          mac-win-target-commands)))
(add-hook 'pre-command-hook 'mac-win-restore-ime-target-commands)

;; M-x でのコマンド選択でもIMEを戻せる．
;; ただし，移動先で q が効かないことがある（要改善）
(add-hook 'minibuffer-setup-hook 'mac-win-save-last-ime-status)
(add-hook 'minibuffer-exit-hook 'mac-win-restore-ime)


;; 自動で ASCII入力から日本語入力に引き戻したい関数（デフォルト設定）
(defvar mac-win-target-commands
  '(find-file save-buffer other-window delete-window split-window))


;; 自動で ASCII入力から日本語入力に引き戻したい関数（追加設定）
;; 指定の関数名でマッチさせるので要注意（ my: を追加すれば，my:a, my:b らも対象になる）

;; バッファリストを見るとき
(add-to-list 'mac-win-target-commands 'helm-buffers-list)
;; ChangeLogに行くとき
(add-to-list 'mac-win-target-commands 'add-change-log-entry-other-window)
;; 個人用の関数を使うとき
(add-to-list 'mac-win-target-commands 'my:)
;; org-mode で締め切りを設定するとき．
(add-to-list 'mac-win-target-commands 'org-deadline)
;; query-replace で変換するとき
(add-to-list 'mac-win-target-commands 'query-replace)

;; change cursor color based on ime status
;; beause mac emacs can't show ime status on mode bar
(defvar my:cursor-color-ime-on "#FF9300")
(defvar my:cursor-color-ime-off "#91C3FF") ;; #FF9300, #999999, #749CCC
(defvar my:cursor-type-ime-on '(bar . 2)) ;; box
(defvar my:cursor-type-ime-off '(bar . 2))

(when (fboundp 'mac-input-source)
    (defun my:mac-keyboard-input-source ()
      (if (string-match "\\.Roman$" (mac-input-source))
          (progn
            (setq cursor-type my:cursor-type-ime-off)
            (add-to-list 'default-frame-alist
                         `(cursor-type . ,my:cursor-type-ime-off))
            (set-cursor-color my:cursor-color-ime-off))
        (progn
          (setq cursor-type my:cursor-type-ime-on)
          (add-to-list 'default-frame-alist
                       `(cursor-type . ,my:cursor-type-ime-on))
          (set-cursor-color my:cursor-color-ime-on)))))

(when (and (fboundp 'mac-auto-ascii-mode)
           (fboundp 'mac-input-source))
      ;; IME ON/OFF でカーソルの種別や色を替える
      (add-hook 'mac-selected-keyboard-input-source-change-hook
                'my:mac-keyboard-input-source)
      (my:mac-keyboard-input-source))

;; たまにカーソルの色が残ってしてしまう．
;; IME ON で英文字打ったあととに，色が変更されないことがある．禁断の対処方法．
(when (fboundp 'mac-input-source)
  (run-with-idle-timer 3 t 'my:mac-keyboard-input-source))

(leaf *cocoa-plantuml
  :defvar (plantuml-jar-path org-plantuml-jar-path)
  :pre-setq ((plantuml-jar-path ."/usr/local/opt/plantuml/libexec/plantuml.jar")
             (org-plantuml-jar-path . plantuml-jar-path)))

(provide 'cocoa-emacs-conf)
;;; cocoa-emacs-conf.el ends here
