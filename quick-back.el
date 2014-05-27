;;; quick-back.el --- simply mark and jump for emacs.

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
  "Destination marker to jump.")
(defvar quick-back-src-marker (make-marker)
  "Source marker of jump.")

(defun quick-back-mark ()
  (interactive)
  (setq quick-back-dest-marker (point-marker))
  (setq quick-back-src-marker (make-marker))
  (message "QB: Marked"))

(defun quick-back-jump ()
  (interactive)
  (let ((dbuf (marker-buffer quick-back-dest-marker))
        (sbuf (marker-buffer quick-back-src-marker)))
    (cond ((null dbuf)
           (error "QB: Marked buffer is nil"))
          ((equal quick-back-dest-marker (point-marker))
           (if (not (null sbuf))
               (quick-back-transition sbuf
                                      quick-back-src-marker
                                      (equal sbuf dbuf)
                                      "QB: Returned")))
          (t
           (setq quick-back-src-marker (point-marker))
           (quick-back-transition dbuf
                                  quick-back-dest-marker
                                  t
                                  "QB: Jumped")))))

(defun quick-back-transition (buf loc rec-flag msg)
  (switch-to-buffer buf)
  (goto-char loc)
  (if rec-flag (recenter))
  (message msg))

(provide 'quick-back)

;;; quick-back.el ends here
