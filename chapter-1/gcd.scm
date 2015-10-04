;;; Bill Xue
;;; 2015-10-04
;;; Compute GCD

;; Method I: Euclid Method
;; GCD(a, b) = GCD(b, r), where r = a mod b

(define (gcd-Euclid a b)
  (if (= b 0)
      a
      (gcd-Euclid b (remainder a b))))

;; Lame' rule:
;; If Euclid Method needs k steps to get GCD
;; then the smaller n is >= Fib(k)
