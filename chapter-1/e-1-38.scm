;;; Bill Xue
;;; 2015-10-06
;;; e-2 to continued fraction

(load "e-1-37.scm")
(define (estimate-e)
  (+ 2
    (cont-frac (lambda (i) 1.0)
               (lambda (i)
                  (cond ((< i 3) i)
                        ((= (remainder (- i 2) 3) 0)
                         (* (/ 2 3) (+ i 1)))
                        (else 1)))
               100)))
