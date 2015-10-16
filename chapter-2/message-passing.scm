;;; Bill Xue
;;; 2015-10-16
;;; Message Passing

;; supplementary procedures
(define (square i) (* i i))

;; Re-implement complex using Message Passing

;; From Ben's implementation
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle)
           (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))

  dispatch)

;; From Alysse's implementation
;; Exercise 2.75
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          ((eq? op 'real-part)
           (* r (cos a)))
          ((eq? op 'imag-part)
           (* r (sin a)))
          (else
           (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))

  dispatch)

;; define generic selecion procedure
(define (apply-generic op arg)
  (arg op))

(define (real-part z)
  (apply-generic 'real-part z))

(define (imag-part z)
  (apply-generic 'imag-part z))

(define (magnitude z)
  (apply-generic 'magnitude z))

(define (angle z)
  (apply-generic 'angle z))

;;; Summary
;;; 1. generic operations with explicit dispatch:
;;;    when add new types, we must add many new procedures
;;;    and check whether name repeated carefully
;;; 2. data-directed style:
;;;    when add new types, we just need to install to new
;;;    package, to insert (op type) coresponding procedure
;;;    no need to check name repeated carefully
;;;
;;; 3. message-passing style:
;;;    have the features of data-directed style
