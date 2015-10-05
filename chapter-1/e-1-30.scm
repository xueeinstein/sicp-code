;;; Bill Xue
;;; 2015-10-05
;;; Rewrite sum using iteration

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))

  ; main
  (iter a 0))

; test sum-iter
(define (sum-integers a b)
  (define (indentity x) x)
  (define (inc x) (+ x 1))

  (sum-iter indentity a inc b))

