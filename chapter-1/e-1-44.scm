;;; Bill Xue
;;; 2015-10-07
;;; Smooth a function

(define (smooth f)
  (define dx 0.00001)

  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
      3.0)))

;; repeated smooth

(load "e-1-43.scm")
(define (repeated-smooth f n)
  (repeated f n))
