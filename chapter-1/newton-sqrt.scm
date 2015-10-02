;;; Bill Xue
;;; 2015-10-01
;;; newton sqrt


;; we can guess a y which may be the sqrt of x
;; then (y + x/y)/2 is a better sqrt(x) estimation


(define (sqrt-iter guess x)
 (if (good-enough? guess x)
  guess
  (sqrt-iter (improve guess x)
              x)))

(define (improve guess x)
 (average guess (/ x guess)))

(define (average x y)
 (/ (+ x y) 2))

;; |y^2 - x| < 0.001 as good enough
;; Actually, it's not a good evaluation
(define (good-enough? guess x)
 (< (abs (- (square guess) x)) 0.001))

(define (square x)
 (* x x))

;;===================================
(define (newton-sqrt x)
 (sqrt-iter 1.0 x))
