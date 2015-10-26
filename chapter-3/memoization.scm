;;; Bill Xue
;;; 2015-10-26
;;; Memoization

;; load table operations
(load "table.scm")

(define (memoize f)
  (let ((table (make-variable-bst-table)))
    (lambda (x)
      (let ((previously-computed-result
              ((table 'lookup) (list x))))
        (or previously-computed-result
            (let ((result (f x)))
              ((table 'insert!) (list x) result)
              result))))))

;; Exercise 3.27
;; Fibonacci Array using memoization
(define memo-fib
  (memoize
    (lambda (n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else
              (+ (memo-fib (- n 1))
                 (memo-fib (- n 2))))))))

; the normal recursive version of fib
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else
          (+ (fib (- n 1))
             (fib (- n 2))))))

;; test:
;; even (memo-fib 100) got result instantly
;; especially, once you computed (memo-fib 1000)
;; try to compute it again, the result is
;; almost already stored in memeory!
