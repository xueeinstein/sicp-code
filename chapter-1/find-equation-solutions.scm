;;; Bill Xue
;;; 2015-10-05
;;; Find equation solutions
;;; Through binary search

(define (search f neg-point pos-point)
  ; supplementary procedure
  (define (average a b)
    (/ (+ a b) 2.0))

  (define (close-enough? x y)
    (< (abs (- x y)) 0.001))

  ; main
  (let ((mid-point (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        mid-point
        (let ((test-value (f mid-point)))
          (cond ((positive? test-value)
                 ; binary the range
                 (search f neg-point mid-point))
                ((negative? test-value)
                 ; binary the range
                 (search f mid-point pos-point))
                (else mid-point))))))

;; smart wrapper
;; so we don't recognize neg-point and pos-point separately
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (positive? a-value) (negative? b-value))
           (search f b a))
          (else
           (display "values are not of opposite sign")))))
