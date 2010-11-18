(setq load-path
     (cons (expand-file-name "~/.emacs.d/elisp/ibus-el") load-path))

;; load ibus.el
(require 'ibus)

; for XFce
; http://d.hatena.ne.jp/grandVin/20100608/1275973364
(defun ibus-get-active-window-id ()
  (string-to-number (frame-parameter (selected-frame) 'outer-window-id)))

(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
;; Change cursor color depending on IBus status
(setq ibus-cursor-color '("SteelBlue" "gray" "dark sea green"))
;; Use s-SPC to toggle input status
(global-set-key "\C-\\" 'ibus-toggle)

; 予測候補ウィンドウの表示位置の変更
(setq ibus-prediction-window-position t)