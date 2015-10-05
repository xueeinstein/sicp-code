;;; Bill Xue
;;; 2015-10-05
;;; Product Abstraction

;; product = f(a) * f(a+1) *...* f(b)
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))


; test: n!
(define (factorial n)
  (define (inc x) (+ x 1))
  (define (identity x) x)

  ; main
  (product identity 1 inc n))

; test: pi
;  pi    2*4*4*6*6*8*...
; --- = -----------------
;  4     3*3*5*5*7*7*...
;
; compute to *(2n)
(define (pi n)
  (define (next x)
    (+ x 2))

  (define (square x)
    (* x x))

  ; main
  (* 4
     (/
        (* 2 (product square 4 next (* 2 n)) (* 2 (+ n 1)))
        (product square 3 next (+ (* 2 n) 1))
        1.0)))
