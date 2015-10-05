;;; Bill Xue
;;; 2015-10-05
;;; Integral by Simpson Rule

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


;; Simpson Rule
;; n is even
;; integral = h/3 * (y_0 + 4y_1 + 2y_2 + ... + 4y_{n-1}+ y_n)
(define (integral f a b n)
  (define h (/ (- b a) (+ n 0.0)))

  (define (term k)
    (*
      (cond ((or (= k 1) (= k n)) 1)
            ((even? k) 2)
            (else 4))
      (f (+ a (* k h)))))

  (define (inc x)
    (+ x 1))

  ; main
  (* (/ h 3.0) (sum term 0 inc n)))
