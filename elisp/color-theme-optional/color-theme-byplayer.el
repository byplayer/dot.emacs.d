(eval-when-compile
  (require 'color-theme))

(defun color-theme-byplayer ()
  "color theme for programming
Created by byplayer <byplayer100@gmail.com> Dec 27 2010"
  (interactive)
  (color-theme-install
   '(color-theme-example
     ((foreground-color . "light gray")
      (background-color . "black")
      (border-color . "black")
      (mouse-color . "light gray")
      (cursor-color . "light gray")
      (background-mode . dark))
     (default ((t (nil))))
     (region ((t (:foreground "black" :background "snow3"))))

     ;; fond-lock
     (font-lock-warning-face ((t (:foreground "NavajoWhite2" :bold nil :weight normal))))
     (font-lock-comment-face ((t (:foreground "NavajoWhite2"))))
     (font-lock-string-face ((t (:foreground "tomato2"))))
     (font-lock-keyword-face ((t (:foreground "DarkSeaGreen3"))))
     (font-lock-constant-face ((t (:foreground "aquamarine3"))))
     (font-lock-type-face ((t (:foreground "DarkOliveGreen3"))))
     (font-lock-variable-name-face ((t (:foreground "burlywood3"))))
     (minibuffer-prompt ((t (:foreground "LightSkyBlue"))))
     (compilation-info ((t (:foreground "DarkOliveGreen3" :bold nil :weight normal))))
     (escape-glyph ((t (:foreground "aquamarine3"))))
     (link ((t (:foreground "LightSkyBlue"))))

     (comint-highlight-prompt ((t (:foreground "LightSkyBlue" :bold nil :weight normal))))

     ;; diff
     (diff-context-face ((t (:foreground "grey50"))))
     (diff-header-face ((t (:background "black" :bold t :weight bold))))
     (diff-file-header-face ((t (:foreground "MediumSeaGreen" :background "black" ))))
     (diff-index-face ((t (:foreground "MediumSeaGreen" :background "black" ))))
     (diff-hunk-header-face ((t (:foreground "plum" :background "black" ))))
     (diff-removed-face ((t (:foreground "gray5"))))
     (diff-added-face ((t (:foreground "white" :background "SaddleBrown" ))))
     (diff-changed-face ((t (:foreground "DeepSkyBlue1"))))

     ;; anything
     (anything-file-name ((t (:foreground "yellow green"))))
     (anything-dir-heading ((t (:foreground "aquamarine3"))))
     (anything-dir-priv ((t (:foreground "DarkSeaGreen3"))))
     (anything-visible-mark ((t (:foreground "black" :background "DarkSeaGreen3"))))
     (anything-ff-directory ((t (:foreground "light gray" :background "steelblue"))))
     (anything-candidate-number ((t (:foreground "black" :background "sandybrown"))))
     (anything-ff-prefix ((t (:foreground "black" :background "sandybrown"))))
     (anything-grep-running ((t (:foreground "Darkorange1" ))))
     (anything-lisp-completion-info ((t (:foreground "Darkorange1" ))))

     ;; whitespace
     (whitespace-space ((t (:foreground "LightSlateGray" :background "DarkSlateGray"))))
     (whitespace-tab ((t (:foreground "LightSlateGray" :background "DarkSlateGray"))))

     ;; ecb
     (ecb-default-highlight-face ((t (:background "steelblue"))))
     (ecb-tag-header-face ((t (:foreground "black" :background "DarkSeaGreen3"))))
     )))



(setq ansi-color-names-vector
      ["black" "dark red" "DarkOliveGreen3" "NavajoWhite2" "LightSkyBlue" "dark magenta"
       "DarkSlateGray2" "white"])
