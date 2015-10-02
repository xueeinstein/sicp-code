;;; Bill Xue
;;; 2015-10-01
;;; newton cube-root with better precision evaluation


;; we can guess a y which may be the cube-root of x
;; then (x/y^2 + 2y)/3 is a better cube-root(x) estimation


(define (cube-root-iter guess guess-old x)
 (if (good-enough? guess guess-old)
  guess
  (cube-root-iter (improve guess x)
              guess
              x)))

(define (improve guess x)
 (one-third (* 2 guess) (/ x (square guess))))

(define (one-third x y)
 (/ (+ x y) 3))

(define (square x)
 (* x x))

;; |y2 - y1| < 0.00001 as good enough
(define (good-enough? guess guess-old)
 (< (abs (- guess guess-old)) 0.00001))

;;===================================
(define (newton-cube-root x)
 (cube-root-iter 1.0 0.0 x))
