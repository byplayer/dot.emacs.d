(eval-when-compile
  (require 'color-theme))

(defun color-theme-byplayer ()
  "color theme for programming
Created by byplayer <byplayer100@gmail.com> Dec 27 2010"
  (interactive)
  (color-theme-install
   '(color-theme-example
     ((foreground-color . "light gray")
      (background-color . "black"))
     (default ((t (nil))))
     ; (border-color . "black")
     ; (mouse-color . "light gray")
     ; (cursor-color . "light gray")
     (region ((t (:foreground "snow3" :background "black"))))
     (font-lock-warning-face ((t (:foreground "NavajoWhite2" :bold nil))))
     )))

