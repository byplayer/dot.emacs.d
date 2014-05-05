;;; package --- Summary
;;; Commentary:
;;; Code:
(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)

(eval-after-load 'flycheck
  '(progn
     (setq lookup-enable-splash nil)
     ; (global-set-key "\C-c\C-l" 'lookup)
     (global-set-key (kbd "C-x W") 'lookup-region)
     (global-set-key (kbd "C-x w") 'lookup-pattern)

     (setq lookup-search-agents
           '(
             (ndeb "~/dic/LDOCE4")
             (ndeb "~/dic/sperdic200")))))

;;; 10-lookup.el ends here
