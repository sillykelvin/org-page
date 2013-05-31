;;; op-enhance.el --- HTML page customization required by org-page

;; Copyright (C) 2012, 2013 Kelvin Hu

;; Author: Kelvin Hu <ini DOT kelvin AT gmail DOT com>
;; Keywords: convenience
;; Homepage: https://github.com/kelvinh/org-page
;; Version: 0.3

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Improve generated html page display effect

;;; Code:

(require 'format-spec)

(defun op/get-theme-dir (theme)
  "Return the resource storage directory of THEME."
  (file-name-as-directory
   (expand-file-name
    (format "themes/%s/resources" (symbol-name 'default))
    op/load-directory)))

(defun op/prepare-theme (pub-root-dir)
  "Copy theme files to PUB-ROOT-DIR."
  (let ((pub-theme-dir (expand-file-name "media/" pub-root-dir))
        (theme-dir (op/get-theme-dir op/theme)))
    (unless (file-directory-p theme-dir)
      (message "Theme %s not found, use `default' theme instead."
               (symbol-name op/theme))
      (setq op/theme 'default)
      (setq theme-dir (op/get-theme-dir 'default)))
    (op/update-theme op/theme)
    (when (file-directory-p pub-theme-dir)
      (delete-directory pub-theme-dir t))
    (copy-directory theme-dir pub-theme-dir t t t)))

(defun op/update-theme (theme)
  "Update theme related variable(s), to make it(them) take effect after user
used a new theme."
  (unless theme
    (setq theme 'default))
  (setq theme (symbol-name theme))
  (setq op/page-template
        (file-to-string
         (concat op/load-directory
                 (format "themes/%s/templates/template.html" theme)))))


(provide 'op-enhance)

;;; op-enhance.el ends here
