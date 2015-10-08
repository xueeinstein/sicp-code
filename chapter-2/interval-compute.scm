;;; Bill Xue
;;; 2015-10-08
;;; Interval Computation


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  ; convert to (mul-interval x 1/y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

;; Exercise 2.7
(define (make-interval a b)
  (cons a b))

(define (upper-bound x)
  (cdr x))

(define (lower-bound x)
  (car x))

;; Exercise 2.8
(define (sub-interval x y)
  ; convert to (add-interval x -y)
  (define neg-y
    (make-interval (- (upper-bound y))
                   (- (lower-bound y))))
  (add-interval x neg-y))

;; Exercise 2.9 pass

;; Exercise 2.10
;; update div-interval, error for dividing
;; an Interval which contains zero
(define (div-interval-update x y)
  ; check whether zero in Interval y
  (if (and (negative? (lower-bound y))
           (positive? (upper-bound y)))
      (begin
        (display "[")
        (display (lower-bound y))
        (display " , ")
        (display (upper-bound y))
        (display "]")
        (display " contains 0!")
        (newline))
        ; convert to (mul-interval x 1/y)
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

;; Exercise 2.11
;; how?

;; Exercise 2.12
;; change to center +/- range format
;; e.g. 3.5 +- 0.15
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (upper-bound i) (lower-bound i)) 2.0))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2.0))

;; change to center, percent format
(define (make-center-percent c p)
  (make-interval (* c (- 1 p)) (* c (+ 1 p))))

(define (center i)
  (/ (+ (upper-bound i) (lower-bound i)) 2.0))

(define (percent i)
  (/ (- (upper-bound i) (center i)) (center i)))

;; Exercise 2.13
;; Assuming all center is positive
(define (mul-interval-update x y)
  (make-interval (* (lower-bound x) (lower-bound y))
                 (* (upper-bound x) (upper-bound y))))

;; Exercise 2.14
;; TODO


;; Exercise 2.15
;; TODO

;; Exercise 2.16
;; TODO
