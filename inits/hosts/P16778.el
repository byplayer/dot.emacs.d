(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(width . 204) ;; ウィンドウ幅
                   '(height . 75) ;; ウィンドウの高さ
                   )
                  initial-frame-alist)))
