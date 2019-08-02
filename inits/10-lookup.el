;;; package --- Summary
;;; Commentary:
;;; Code:
;; lookup
(add-to-list 'load-path "~/.emacs.d/elisp/lookup/")

(load "lookup-autoloads")

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
