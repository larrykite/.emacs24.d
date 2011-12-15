;;; apropos+.el --- Extensions to `apropos.el'
;;
;; Filename: apropos+.el
;; Description: Extensions to `apropos.el'
;; Author: Drew Adams
;; Maintainer: Drew Adams
;; Copyright (C) 1996-2011, Drew Adams, all rights reserved.
;; Created: Thu Jun 22 15:07:30 2000
;; Version: 21.0
;; Last-Updated: Mon Jan  3 14:47:59 2011 (-0800)
;;           By: dradams
;;     Update #: 46
;; URL: http://www.emacswiki.org/cgi-bin/wiki/apropos+.el
;; Keywords: help
;; Compatibility: GNU Emacs: 20.x, 21.x, 22.x, 23.x
;;
;; Features that might be required by this library:
;;
;;   `apropos'.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; New command `apropos-user-options'.
;;
;;  It only lists user-definable variables.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;; 2007/11/27 dadams
;;     apropos-user-options: If available, use icicle-read-string-completing.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'apropos)

;;;;;;;;;;;;;;;;;;;;;;;;;


;;;###autoload
(defun apropos-user-options (regexp)
  "Show user variables that match REGEXP."
  (interactive
   (list (if (fboundp 'icicle-read-string-completing)
             (icicle-read-string-completing "Apropos user options (regexp): ")
           (read-string "Apropos user options (regexp): "))))
  (let ((apropos-do-all nil))
    (apropos-variable regexp)))

;;;;;;;;;;;;;;;;;;;;;;;

(provide 'apropos+)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; apropos+.el ends here
