(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(width . 205) ;; ウィンドウ幅
                   '(height . 72) ;; ウィンドウの高さ
                   )
                  initial-frame-alist)))
