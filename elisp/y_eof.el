;;; y_eof.el --- 

;; Copyright (C) 1999 by Free Software Foundation, Inc.

;; Author: 
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:

; y-eof.el
;; 改行コードを表示させるのは、hilit19 を使ってすべての
;; 改行文字に対してやらせたら遅くて使いものにならなかったので、
;; 空白の後に改行コードが入っているものに色をつけることで我慢しています。
;; 例えば、c-mode でその機能を使うには、
;; (hilit-add-mode-patterns 'c-mode '(("[ \t]+$" nil blue-back)))
;; のようにします。

(set-face-background (make-face 'yellow-back) "yellow")
(set-face-foreground 'yellow-back "black")
(defvar last-overlay-arrow-string nil)
(defvar last-overlay-arrow-position nil)
(make-variable-buffer-local 'overlay-arrow-string)
(make-variable-buffer-local 'overlay-arrow-position)
(defun move-eof-string (beg end old-len)
  (and (markerp overlay-arrow-position)
       (set-marker overlay-arrow-position (point-max))
       (setq last-overlay-arrow-string overlay-arrow-string)
       (setq last-overlay-arrow-position overlay-arrow-position)
       (set-buffer-modified-p (buffer-modified-p)) ; update screen
       ))
(defun reset-eof-string (old-win new-win)
  (and (boundp 'show-eof-string:select-window-hook)
       show-eof-string:select-window-hook
       (funcall show-eof-string:select-window-hook old-win new-win))
  (if (boundp 'show-eof-string)
      (setq last-overlay-arrow-string overlay-arrow-string
	    last-overlay-arrow-position overlay-arrow-position)
    (setq overlay-arrow-string last-overlay-arrow-string
	  overlay-arrow-position last-overlay-arrow-position))
  )
(defun show-eof-string ()
  (set (make-local-variable 'show-eof-string) t)
  (add-hook (make-local-variable 'after-change-functions) 'move-eof-string)
;    (make-local-variable 'overlay-arrow-string)
;    (make-local-variable 'overlay-arrow-position)
  (setq overlay-arrow-string #("<EOF>" 0 5 (face yellow-back)))
  (or (markerp overlay-arrow-position)
      (setq overlay-arrow-position (make-marker)))
  (move-eof-string (point-min) (point-max) 0)
  )
(and (and (boundp 'select-window-hook) select-window-hook
	  (not (boundp 'show-eof-string:select-window-hook)))
     (setq show-eof-string:select-window-hook select-window-hook
	   select-window-hook 'reset-eof-string))
(add-hook 'find-file-hooks 'show-eof-string)


;;; y_eof.el ends here