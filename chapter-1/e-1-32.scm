;;; Bill Xue
;;; 2015-10-05
;;; Accumulate
;;; from Accumulate to Sum and Product

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
        (accumulate
          combiner null-value term (next a) next b))))

;; test: sum
(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (sum-integers a b)
  ; supplementary functions
  (define (identity x) x)

  (define (inc x)
    (+ x 1))

  ; main
  ; implement from abstract function
  (sum identity a inc b));

;; test: product
(define (product term a next b)
  (accumulate * 1 term a next b))

(define (factorial n)
  (define (inc x) (+ x 1))
  (define (identity x) x)

  ; main
  (product identity 1 inc n))


;; ===============================
;; Accumulate iteration

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))

  (iter a null-value))

;; test: sum

(define (sum-iter term a next b)
  (accumulate + 0 term a next b))

(define (sum-iter-integers a b)
  ; supplementary functions
  (define (identity x) x)

  (define (inc x)
    (+ x 1))

  ; main
  ; implement from abstract function
  (sum identity a inc b));

