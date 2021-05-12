;;; langtool-ignore-fonts.el --- Force langtool to ignore certain fonts  -*- lexical-binding: t -*-

;; Copyright (C) 2021 Christopher Lloyd

;; Author: Christopher Lloyd <cjl8zf@virginia.edu>
;; URL: https://github.com/cjl8zf/langtool-ignore-fonts
;; Version: 0.1
;; Package-Requires: ((emacs "25.1") (langtool "2.2.1"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
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

;; Force langtool to ignore certain fonts.

;;; Code:

(defcustom langtool-ignore-fonts nil
  "List of font faces that langtool should ignore.

   For example, the default values prevent langtool from trying to
   correct LaTeX math or comments.

   This variable is buffer local so that the behavior of langtool
   can be altered based on the current 'major-mode."
  :type 'sexp
  :group 'langtool)

(make-local-variable 'langtool-ignore-fonts)

(defun langtool-ignore-fonts-get-overlays ()
  "Find all of the langtool overlays.

  This function assumes that `langtool-check' has already been run.

  We first call 'font-lock-ensure to ensure that reigons outside
  of acessible buffer have had font-lock applied."
  (progn
    (font-lock-ensure)
    (seq-filter
     (lambda (ov) (overlay-get ov 'langtool-message))
     (overlays-in 0 (buffer-size)))))

(defun langtool-ignore-fonts-overlay-has-matched-font (ov)
  "Check to see if the overlay OV region font is on our list of fonts."
  (or (langtool-ignore-fonts-matched-font-at (overlay-start ov))
      (langtool-ignore-fonts-matched-font-at (overlay-end ov))))

(defun langtool-ignore-fonts-matched-font-at (pos)
  "Check to see if the character at POS has a font from the `langtool-ignore-fonts' list."
  (< 0 (length (cl-intersection langtool-ignore-fonts
				(langtool-ignore-fonts-treat-as-list (get-text-property pos 'face))))))

(defun langtool-ignore-fonts-treat-as-list (x)
  "If X is a single value wrap it as a singleton otherwise leave it alone."
  (if (listp x) x (list x)))

(defun langtool-ignore-fonts-get-matched-font-overlays ()
  "Get a list of all of the langtool-overlays that match the `langtool-ignore-fonts' list."
  (seq-filter #'langtool-ignore-fonts-overlay-has-matched-font (langtool-ignore-fonts-get-overlays)))

(defun langtool-ignore-fonts-delete-matched-overlays ()
  "Delete any langtool overlays that match the font list `langtool-ignore-fonts'."
  (interactive)
  (mapc #'delete-overlay (langtool-ignore-fonts-get-matched-font-overlays)))

(defun langtool-ignore-fonts-delete-matched-overlays-advice (&rest args)
  "Advise with ARGS to remove langtool overlays that match the font list.
   
  This function should be called after 'langtool--check-finish."
  (progn
    (message "Removing langtool overlays matching 'langtool-ignore-fonts.")
    (mapc #'delete-overlay (langtool-ignore-fonts-get-matched-font-overlays))
    (message "Done removing overlays.")))

;;;  Add support for LaTeX
(add-hook 'LaTeX-mode-hook (lambda ()
			     (setq-local langtool-ignore-fonts '(font-lock-comment-face
								 font-latex-math-face
								 font-latex-string-face))))

(advice-add 'langtool--check-finish :after #'langtool-ignore-fonts-delete-matched-overlays-advice)

(provide 'langtool-ignore-fonts)

(provide 'langtool-ignore-fonts)
;;; langtool-ignore-fonts.el ends here
