;;; Bill Xue
;;; 2015-10-06
;;; tan(x) to continued fraction

(load "e-1-37.scm") ; load cont-frac
(define (tan-cf x k)
  (cont-frac (lambda (i)
              (if (= i 1)
                  x
                  (- (* x x))))
             (lambda (i) (- (* 2 i) 1))
             k))
