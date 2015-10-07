;;; Bill Xue
;;; Procedure as Return Value

;; Example
(define (average-damp f)
  (define (average a b)
    (/ (+ a b) 2.0))

  ; return procedure
  (lambda (x) (average x (f x))))

;; test
(load "fixed-point.scm")
(define (sqrt-me x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
                1.0))
