;;; Bill Xue
;;; 2015-10-06
;;; Double procedure

(define (double g)
  (lambda (x)
    (g (g x))))

;; test: Double inc
(define (double-inc x)
  (define (inc x)
    (+ x 1))

  ((double inc) x))

(define (test)
  (((double (double double))
    (lambda (i) (+ i 1))) 5))
