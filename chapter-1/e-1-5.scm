;;; Bill Xue
;;; 2015-10-01
;;; Ben Bitdiddle's method to detect
;;; interpreter sequence evaluation


(define (p) (p))

(define (test x y)
 (if (= x 0)
  0
  y))

;(test 0 (p))
;;if the interpreter use in-order sequence
;;it will return 0
;;if the interpreter use application order sequence
;;it will loop forever!!
