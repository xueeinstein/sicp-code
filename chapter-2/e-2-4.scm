;;; Bill Xue
;;; 2015-10-07
;;; Cons Pair

;; Method I
(define (cons-v1 x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (display "Argument not 0 or 1 -- CONS"))))

  ; return dispatch
  dispatch)

(define (car-v1 z) (z 0))

(define (cdr-v1 z) (z 1))

;; Method II
(define (cons-v2 x y)
  ; here m is also a procedure
  (lambda (m) (m x y)))

(define (car-v2 z)
  (z (lambda (p q) p)))

(define (cdr-v2 z)
  (z (lambda (p q) q)))
