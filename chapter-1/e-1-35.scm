;;; Bill Xue
;;; 2015-10-06
;;; Golden Cut
;;; The ratio is the fixed point of
;;; x -> 1 + 1/x

(load "fixed-point.scm")

(define Golden-Cut-Ratio
  (fixed-point (lambda (x) (+ 1 (/ 1.0 x))) 1.0))
