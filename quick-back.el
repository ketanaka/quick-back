;;; quick-back.el --- simply mark and jump for emacs. -*- lexical-binding: t; -*-

;; Copyright (C) 2014 Keisuke Tanaka

;; Author: Keisuke Tanaka <lego.sw@gmail.com>
;; Keywords: convenience
;; URL: http://github.com/ketanaka/quick-back

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

;;; Code:

(defvar quick-back-dest-marker (make-marker)
  "Marker remembered as the jump destination.")
(defvar quick-back-src-marker (make-marker)
  "Marker remembered as the return point for the round-trip jump.")

(defun quick-back-mark ()
  "Mark the current point as the destination for `quick-back-jump'."
  (interactive)
  (setq quick-back-dest-marker (point-marker))
  (setq quick-back-src-marker (make-marker))
  (message "QB: Marked"))

(defun quick-back-jump ()
  "Jump to the position marked by `quick-back-mark'.
Invoking this command at the marked position jumps back to the
position from which the previous jump was made (round-trip jump)."
  (interactive)
  (let ((dbuf (marker-buffer quick-back-dest-marker)))
    (cond ((null dbuf)
           (user-error "QB: No mark set"))
          ((equal quick-back-dest-marker (point-marker))
           (when (marker-buffer quick-back-src-marker)
             (quick-back--transition quick-back-src-marker "QB: Returned")))
          (t
           (setq quick-back-src-marker (point-marker))
           (quick-back--transition quick-back-dest-marker "QB: Jumped")))))

(defun quick-back--transition (marker msg)
  "Switch to MARKER's buffer and move point to its position.
Call `recenter' only when the destination is not visible in the
selected window, then display MSG in the echo area."
  (switch-to-buffer (marker-buffer marker))
  (goto-char marker)
  (unless (pos-visible-in-window-p)
    (recenter))
  (message msg))

(provide 'quick-back)

;;; quick-back.el ends here
