;;; Bill Xue
;;; 2015-10-01
;;; Implement newton sqrt using self-define
;;; new-if

(define (new-if predicate then-clause else-clause)
 (cond (predicate then-clause)
  (else else-clause)))

(define (sqrt-iter guess x)
 (new-if (good-enough? guess x)
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
;; the new-if causes infinity loop!!!
;; TODO, why? what's wrong with 'new-if'
(define (newton-sqrt-new-if x)
 (sqrt-iter 1.0 x))
