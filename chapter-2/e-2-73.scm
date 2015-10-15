;;; Bill Xue
;;; 2015-10-15
;;; Exercise 2.73
;;; Re-implement derivate using data-directed programming

;; supplementary procedures
(load "put-get.scm")
(define (variable? x)
  (symbol? x))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))

;; generic deriv implementation
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var)
             1
             0))
        (else
          ((get 'deriv (operator exp))
             (operands exp)
             var))))

(define (install-sum-product-package)
  ;; internal procedures
  (define (make-sum x y)
    (cond ((=number? x 0) y)
          ((=number? y 0) x)
          ((and (number? x) (number? y))
           (+ x y))
          (else (list '+ x y))))

  (define (addend exp)
    (car exp))

  (define (augend exp)
    (cadr exp))

  (define (make-product x y)
    (cond ((or (=number? x 0) (=number? y 0)) 0)
          ((=number? x 1) y)
          ((=number? y 1) x)
          ((and (number? x) (number? y)) (* x y))
          (else (list '* x y))))

  (define (multiplier exp)
    (car exp))

  (define (multiplicand exp)
    (cadr exp))

  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))

  (define (deriv-product exp var)
    (make-sum
      (make-product (multiplier exp)
                (deriv (multiplicand exp) var))
      (make-product (multiplicand exp)
                (deriv (multiplier exp) var))))

  ;; interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  'done)

;; install package
(install-sum-product-package)

;; add new exponentiation package
(define (install-exponentiation-package)
  ;; internal procedures
  (define (exponentiation? exp)
    (number? (cadr exp)))  ; exp is in format (x y) not (** x y)

  (define (make-exponentiation base exponent)
    (cond ((=number? exponent 0) 1)
          ((=number? exponent 1) base)
          ((=number? base 1) 1)
          (else (list '** base exponent))))

  (define (base exp)
    (car exp))

  (define (exponent exp)
    (cadr exp))

  (define (make-product x y)
    (cond ((or (=number? x 0) (=number? y 0)) 0)
          ((=number? x 1) y)
          ((=number? y 1) x)
          ((and (number? x) (number? y)) (* x y))
          (else (list '* x y))))

  (define (deriv-exponentiation exp var)
    (if (not (exponentiation? exp))
        (error
          "The exponent expect to be number --
           DERIV-EXPONENTIATION "
           (exponent exp))
        (make-product (deriv (base exp) var)
                      (make-product
                        (exponent exp)
                        (make-exponentiation
                          (base exp)
                          (- (exponent exp) 1))))))

  ;; interface to the rest of the system
  (put 'deriv '** deriv-exponentiation)
  'done)

;; install package
(install-exponentiation-package)
