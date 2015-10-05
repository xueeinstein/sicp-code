;;; Bill Xue
;;; 2015-10-05
;;; Filtered Accumulate

(define (filtered-accumulate
          filter?
          combiner null-value term a next b)
  "accumulate filtered numbers"
  (if (> a b)
      null-value
      (combiner
        ; filter a
        (if (filter? a)
            (term a)
            null-value)
        ; recursed filtered-accumulate
        (filtered-accumulate
          filter? combiner null-value term
          (next a) next b))))

;; test: sum up all prime between a and b
(load "check-prime.scm")
(define (sum-primes a b)
  (define (identity x) x)
  (define (inc x) (+ x 1))

  (filtered-accumulate
    prime-by-divisor? + 0 identity a inc b))

;; test: product of all i, which 0<i<n and GCD(i, n) = 1
(define (product-i n)
  (define (identity x) x)
  (define (inc x) (+ x 1))

  (define (gcd-eq-1? x)
    (= (gcd x n) 1))

  (filtered-accumulate
    gcd-eq-1? * 1 identity 1 inc (- n 1)))
