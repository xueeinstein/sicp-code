;;; Bill Xue
;;; 2015-10-07
;;; Iterative Improve

(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve)
           (improve guess)))))

;; test: sqrt rewrite
(define (sqrt-iter-improve x)
  (define (good-enough? y)
    (< (abs (- (* y y) x)) 0.0001))

  (define (improve y)
    (/ (+ y (/ x y)) 2.0))

  ((iterative-improve good-enough? improve) 1.0))

;; test: fixed-point rewrite
(define (fixed-point-iter-improve f first-guess)
  (define tolerance 0.00001)

  (define (close-enough? guess)
    (< (abs (- guess (f guess))) tolerance))

  ((iterative-improve close-enough? f) first-guess))

; test: find fixed point of cos(x)
(fixed-point-iter-improve cos 1.0)
