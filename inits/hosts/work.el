(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(width . 207) ;; ウィンドウ幅
                   '(height . 73) ;; ウィンドウの高さ
                   )
                  initial-frame-alist)))
