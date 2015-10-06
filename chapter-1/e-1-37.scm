;;; Bill Xue
;;; 2015-10-06
;;; Continued Fraction

;; Recursive implementation
(define (cont-frac n d k)
  ; a_i = Ni / ( Di + a_{i+1} ), i<k
  ; a_k = Nk / Dk, i=k
  (define (cont-frac-main index)
    (if (= index k)
        (/ (n index) (d index) 1.0)
        (/ (n index)
           (+ (d index)
              (cont-frac-main (+ index 1))))))

  (cont-frac-main 1))

;; test: n, d are both 1
;; increase k until the Continued Fraction
;; approach Golden Cut Ratio
(load "e-1-35.scm") ; load Golden Cut Ratio
(define (approach-gcr)
  (define (close-enough? v1 v2 tolerance)
    (< (abs (- v1 v2)) tolerance))

  (do ((tolerance 0.0001)
       (one-gcr (/ 1.0 Golden-Cut-Ratio))
       (cf-value 0)
       (k 0))
      ((close-enough? cf-value one-gcr tolerance)
       k) ; if close enough, return k
      (begin
        (set! k (+ k 1))
        (set! cf-value
              (cont-frac (lambda (i) 1.0)
                         (lambda (i) 1.0)
                         k)))))

;; Iteration implementation
