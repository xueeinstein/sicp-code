;;; Bill Xue
;;; 2015-10-07
;;; Rational Number Abstraction

;; Exercise 2.1
;; Make better make-rat
(define (make-rat n d)
  ; simplify the sign
  (if (negative? d)
      (begin
          (set! d (- d))
          (set! n (- n))))
  ;
  ; simplify the numerator and denominator
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

;; Basical operations of Rational Number
;;
;; Because of abstraction, if we need to simplify
;; the numerator and denominator, no need to change
;; fellowing operations
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))