;;; Bill Xue
;;; 2015-10-07
;;; Line (in a panel) Abstraction

;; Point Abstraction
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; Line Abstraction
(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (midpoint-segment segment)
  (make-point
    (/ (+
          (x-point (start-segment segment))
          (x-point (end-segment segment)))
       2.0)
    (/ (+
          (y-point (start-segment segment))
          (y-point (end-segment segment)))
       2.0)))
