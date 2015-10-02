;;; Bill Xue
;;; 2015-10-01
;;; newton sqrt with better precision evaluation


;; we can guess a y which may be the sqrt of x
;; then (y + x/y)/2 is a better sqrt(x) estimation


(define (sqrt-iter guess guess-old x)
 (if (good-enough? guess guess-old)
  guess
  (sqrt-iter (improve guess x)
              guess
              x)))

(define (improve guess x)
 (average guess (/ x guess)))

(define (average x y)
 (/ (+ x y) 2))

;; |y2 - y1| < 0.00001 as good enough
(define (good-enough? guess guess-old)
 (< (abs (- guess guess-old)) 0.00001))

;;===================================
(define (newton-sqrt x)
 (sqrt-iter 1.0 0.0 x))
