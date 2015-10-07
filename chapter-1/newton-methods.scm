;;; Bill Xue
;;; 2015-10-06
;;; Newton Methods
;;; one solution of g(x)=0
;;; is the fixed point of
;;; x -> f(x) = x - g(x)/Dg(x)

(load "fixed-point.scm")
(define (newton-method g guess)
  ; transfroms g(x)=0
  ; to f(x) fixed point problem
  (define (newton-transform g)
    (lambda (x)
      (- x (/ (g x) ((deriv g) x)))))

  ; derivative g(x)
  (define (deriv g)
    (lambda (x)
      (/ (- (g (+ x dx)) (g x))
         dx)))
  (define dx 0.00001)

  ; main
  (fixed-point (newton-transform g) guess))

;; test: solve g(y) = y^2 - x = 0
;; then get sqrt(x)
(define (sqrt-me x)
  (newton-method
    (lambda (y) (- (* y y) x))
    1.0))
