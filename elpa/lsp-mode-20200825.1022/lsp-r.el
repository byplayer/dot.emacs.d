;;; lsp-r.el --- description -*- lexical-binding: t; -*-

;; Copyright (C) 2020 emacs-lsp maintainers

;; Author: emacs-lsp maintainers
;; Keywords: lsp, r

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; LSP Clients for the R Programming Language.

;;; Code:

(require 'lsp-mode)

(defgroup lsp-r nil
  "LSP support for R."
  :group 'lsp-mode
  :link '(url-link "https://github.com/REditorSupport/languageserver"))

(defcustom lsp-clients-r-server-command '("R" "--slave" "-e" "languageserver::run()")
  "Command to start the R language server."
  :group 'lsp-r
  :risky t
  :type '(repeat string))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection lsp-clients-r-server-command)
                  :major-modes '(ess-r-mode)
                  :server-id 'lsp-r))


(provide 'lsp-r)
;;; lsp-r.el ends here
