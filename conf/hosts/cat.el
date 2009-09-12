(if (boundp 'window-system)
    (setq initial-frame-alist
          (append (list
                   '(width . 202) ;; ウィンドウ幅
                   '(height . 58) ;; ウィンドウの高さ
                   )
                  initial-frame-alist)))