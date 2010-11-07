;;; immigrant.el --- delicatessen from other lisps

;; Copyright (C) 2010  Jonas Bernoulli

;; Author: Giants
;; Maintainer: Jonas Bernoulli <jonas@bernoul.li>
;; Created: 20101107
;; Updated: 20101107
;; Version: 0.1
;; Homepage: http://github.com/tarsius/immigrant
;; Keywords: convenience lisp

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package defines some functions and macros found in lisps other
;; than Emacs lisp (and maybe other languages too sometime).  History
;; has shown that a culture can benefit from embracing immigrants so
;; why should programming languages be any different? :-)

;; Please send my Emacs lisp implementations of your favorite lisp's
;; functions and macros so that I can include them here.  Or improve
;; those already included.

;; "*" is used as prefix because using e.g. `immigrant-filter' instead
;; of `*filter' just wouldn't be as much fun anymore.

;;; Code:

(require 'cl) ; get over it!

(defmacro *filter (pred sequence)
  "Return a list of the elements of sequence for which PRED returns non-nil."
  `(mapcan (lambda (elt) (when (funcall ,pred elt) (list elt))) ,sequence))

(defmacro *remove (pred sequence)
  "Return a list of the elements of sequence for which PRED returns nil."
  `(mapcan (lambda (elt) (unless (funcall ,pred elt) (list elt))) ,sequence))

(defmacro *partial (function &rest args)
  "Return a partial function wrapping FUNCTION with ARGS applied.
The returned function when called calls function with ARGS and the
additional arguments it is called with."
  `(lambda (&rest args) (apply ,function ,@args args)))

(defmacro *limited (function &rest args)
  "Return a partial function wrapping FUNCTION with ARGS applied last.
The returned function when called calls function with the additional
arguments it is called with and then ARGS.  Like `*partial' but deals
with the fact that in Emacs lisp argument order is usually unsuitable
for such things."
  `(lambda (&rest args) (apply ,function (nconc args (quote ,args)))))

(provide 'immigrant)
;;; immigrant.el ends here
