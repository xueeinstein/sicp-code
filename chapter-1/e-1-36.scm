;;; Bill Xue
;;; 2015-10-06
;;; Fixed Point with Time Cost Report


(define (fixed-point-with-report f first-guess)
  (define tolerance 0.00001)
  (define total-steps 1)

  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    ; report guess
    (report-guess guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          (begin
            (display "total steps: ")
            (display total-steps)
            (newline)
            next)
          (begin
            (set! total-steps (+ total-steps 1))
            (try next)))))

  (define (report-guess guess)
    (display " *** ")
    (display guess)
    (newline))

  ; main
  (try first-guess))

;; test: sqrt
(define (sqrt-me x)
  (fixed-point-with-report
    (lambda (y) (/ (+ y (/ x y)) 2.0)) 1.0))

;; test: find x^x = 1000 solution
(define (x-power-x-halfed)
  (fixed-point-with-report
    (lambda (x) (/ (+ x (/ (log 1000) (log x))) 2.0))
    ; first guess
    ; it cannot be 1
    ; because (log 1) = 0
    2.0))

(define (x-power-x-unhalf)
  (fixed-point-with-report
    (lambda (x) (/ (log 1000) (log x) 1.0))
    2.0))

;; Report: halfed version only cost 9 steps
;; unhalf version cost 34 steps
