;;; Bill Xue
;;; 2015-10-07
;;; sqrt_n
;;; find the fixed point of
;;; y -> x/y^{n-1}


(define (average-damp f)
  (define (average a b)
    (/ (+ a b) 2.0))

  ; return procedure
  (lambda (x) (average x (f x))))

;; load fixed-point-of-transform
(load "fixed-point.scm")

;; load repeated
(load "e-1-43.scm")

;; main
(define (sqrt-n x n k)
  (fixed-point-of-transform 
    (lambda (y) (/ x (expt y (- n 1))))
    ; transform: k times average-damp
    (repeated average-damp k)
    ; first guess
    1.0))

;; Results:
;; for n = 4, k = 1 couldn't converge,
;; but with k = 2, it converges rapidly
