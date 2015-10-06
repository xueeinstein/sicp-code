;;; Bill Xue
;;; 2015-10-05
;;; Fixed Point
;;; f(x) = x

(define (fixed-point f first-guess)
  (define tolerance 0.00001)

  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))

  ; main
  (try first-guess))

; test: find fixed point of cos(x)
(fixed-point cos 1.0)

; test: sqrt
; y = x/y, but we search y-> (1/2)(y + x/y)
; to avoid fixed-point vibration
(define (sqrt-me x)
  (fixed-point (lambda (y) (
                            ; average
                            (lambda (a b) (/ (+ a b) 2.0))
                            y
                            (/ x y)))
                1.0 ; first-guess
                ))
