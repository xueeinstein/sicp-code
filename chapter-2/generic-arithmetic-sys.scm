;;; Bill Xue
;;; 2015-10-16
;;; Generic Arithmetic System

;;; Abstraction
;;;
;;; --------------add sub mul div------------------
;;;
;;; --add-rat..---|--add-complex..---|-- + - * / --|
;;; --mul-rat..---|--mul-complex..---|-------------|
;;;               |                  |             |
;;; rational      |  complex         |  normal     |
;;; computations  |  computations    |  computations
;;; ------------------------------------------------
;;;
;;; new top level operations: equ? & =zero?


;; Using data-directed style
(load "put-get.scm")

;; top level
(define (add x y)
  (apply-generic 'add x y))

(define (sub x y)
  (apply-generic 'sub x y))

(define (mul x y)
  (apply-generic 'mul x y))

(define (div x y)
  (apply-generic 'div x y))

(define (equ? x y)
  (apply-generic 'equ? x y))

(define (=zero? x)
  (apply-generic '=zero? x))

(define (exp x y)
  ; new operation for coercion test
  (apply-generic 'exp x y))

;; normal computations
(define (install-scheme-number-package)
  ; internal procedures
  (define (tag x)
    (attach-tag 'scheme-number x))

  ; interface to rest of the system
  (put 'add                           ; op
       '(scheme-number scheme-number) ; types
       (lambda (x y) (tag (+ x y))))

  (put 'sub
       '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))

  (put 'mul
       '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))

  (put 'div
       '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))

  (put 'exp
       '(scheme-number scheme-number)
        ; new operation for coercion test
       (lambda (x y) (tag (expt x y))))

  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
;; end of normal computations

;; rational computations
(define (install-rational-package)
  ; internal procedures
  (define (make-rat n d)
    ; simplify the sign
    (if (negative? d)
        (begin
            (set! d (- d))
            (set! n (- n))))
    ; simplify the numerator and denominator
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))

  (define (numer x) (car x))

  (define (denom x) (cdr x))

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

  ; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))

  (put 'add
       '(rational rational)
       (lambda (x y) (tag (add-rat x y))))

  (put 'sub
       '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))

  (put 'mul
       '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))

  (put 'div
       '(rational rational)
       (lambda (x y) (tag (div-rat x y))))

  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))

  (put 'numer '(rational) numer)

  (put 'denom '(rational) denom)
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (numer r)
  (apply-generic 'numer r))

(define (denom r)
  (apply-generic 'denom r))
;; end of rational computations

;; complex computations

; load complex rectangular and polar implementations
(load "data-directed-complex.scm")

(define (install-complex-package)
  ; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag
      (+ (real-part z1) (real-part z2))
      (+ (imag-part z1) (imag-part z2))))

  (define (sub-complex z1 z2)
    (make-from-real-imag
      (- (real-part z1) (real-part z2))
      (- (imag-part z1) (imag-part z2))))

  (define (mul-complex z1 z2)
    (make-from-mag-ang
      (* (magnitude z1) (magnitude z2))
      (+ (angle z1) (angle z2))))

  (define (div-complex z1 z2)
    (make-from-mag-ang
      (/ (magnitude z1) (magnitude z2))
      (- (angle z1) (angle z2))))

  ; interface to rest of the system
  (define (tag x) (attach-tag 'complex x))

  (put 'add
       '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))

  (put 'sub
       '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))

  (put 'mul
       '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))

  (put 'div
       '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))

  (put 'real-part '(complex) real-part)

  (put 'imag-part '(complex) imag-part)

  (put 'magnitude '(complex) magnitude)

  (put 'angle '(complex) angle)

  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))

  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))
;; end of complex computations

;; generic version of equ?
(define (install-equ-package)
  ; internal procedures
  (define (equ-scheme-number? x y)
    (= x y))

  (define (equ-rational? x y)
    ; here, accepted arg is (numer . denom)
    ; not ('rational numer . denom) !
    (and (= (car x) (car y))
         (= (cdr x) (cdr y))))

  (define (equ-complex? x y)
    (and (= (real-part x) (real-part y))
         (= (imag-part x) (imag-part y))))

  ; interface to rest of the system
  (put 'equ?
       '(scheme-number scheme-number)
       (lambda (x y) (equ-scheme-number? x y)))

  (put 'equ?
       '(rational rational)
       (lambda (x y) (equ-rational? x y)))

  (put 'equ?
       '(complex complex)
       (lambda (x y) (equ-complex? x y)))
  'done)
;; end of equ?

;; generic version of =zero?
(define (install-zero?-package)
  ; internal procedures
  (define (=zero-scheme-number? x)
    (zero? x))

  (define (=zero-rational? x)
    (zero? (car x)))

  (define (=zero-complex? x)
    (and (zero? (real-part x))
         (zero? (imag-part x))))

  ; interface to rest of the system
  (put '=zero?
       '(scheme-number)
       (lambda (x) (=zero-scheme-number? x)))

  (put '=zero?
       '(rational)
       (lambda (x) (=zero-rational? x)))

  (put '=zero?
       '(complex)
       (lambda (x) (=zero-complex? x)))
  'done)
;; end of =zero?

;; Supplementary procedures
;;
;; To overwrite the corresponding procedures
;; in "data-directed-complex.scm",
;; put all of them to the end

(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((number? datum) 'scheme-number)
        (else
         (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (else
         (error "Bad tagged datum -- CONTENTS" datum))))

(define (apply-generic op . args)
  (begin
    (display "here@@@@")
    (newline)
    (display op)
    ;(newline)
    ;(display (car args))
    (newline)
    (display args)
    (newline))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))  ; get specified procedure
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))


;; install packages
(install-scheme-number-package)

(install-rational-package)

(install-complex-package)

(install-equ-package)

(install-zero?-package)

;; Exercise 2.77
;; The complex z is 3+4i
;; (magnitude z) called apply-generic 2 times
;; First, from complex to polar
;; Second, from polar to its internal procedure

;; Exercise 2.78
;; type-tag, contents and attach-tag
;; already updated on above
;; to support scheme build-in number

;; Exercise 2.79
;; add new package, equ?
;; Please check above

;; Exercise 2.80
;; add new package, =zero?
;; Please check above
