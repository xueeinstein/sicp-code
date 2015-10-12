;;; Bill Xue
;;; 2015-10-12
;;; Symbolic Data

(define (memq-me item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) x)
        (else (memq-me item (cdr x)))))

;; Exercise 2.53
;; Too Simple, passed

;; Exercise 2.54
(define (equal-me? a b)
  (cond ((and (null? a) (null? b)) #t)
        ((and (null? a) (not (null? b))) #f)
        ((and (null? b) (not (null? a))) #f)
        (else (and (eq? (car a) (car b))
                   (equal-me? (cdr a) (cdr b))))))

;; Exercise 2.55
;; (car ''a) get output 'quote'
;; because 'a equal to (quote a), which is a symbolic data
;; and ''a equal to (quote (quote a)) is cons pair
;; so (car ''a) get 'quote'

;; end of Exercise 2.55


;; Derivate

;; supplementary procedure for derive
(define (variable? x)
  "is x a variable?"
  (symbol? x))

(define (=number? exp num)
  "check whether exp is expression and equal to num"
  (and (number? exp) (= exp num)))

(define (same-variable? v1 v2)
  "are v1 and v2 the same variable?"
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (sum? e)
  "check whether expression e is in u+v format"
  (and (pair? e) (eq? (car e) '+)))

(define (addend s)
  "get u from (+ u v)"
  (cadr s))

(define (augend s)
  "get v from (+ u v)"
  (caddr s))

(define (product? e)
  "check whether expression e is production"
  (and (pair? e) (eq? (car e) '*)))

(define (multiplier p)
  "get u from (* u v)"
  (cadr p))

(define (multiplicand p)
  "get v from (* u v)"
  (caddr p))

;; derivate main
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
            (make-product (multiplier exp)
                          (deriv (multiplicand exp) var))
            (make-product (multiplicand exp)
                          (deriv (multiplier exp) var))))
        (else
          ; currently, don't support divide, exp and so on..
          (display "unknow expression type "))))

;; =======================
;; Exercises
;; =======================

;; Exercise 2.56
;; add new derivate rule to deriv
;; d(u^n)
;; ----- = ...
;;  dx
;; using '(** u n)' representing u^n
(define (exponentiation? e)
  (and (pair? e) (eq? (car e) '**) (number? (caddr e))))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((=number? base 1) 1)
        (else (list '** base exponent))))

(define (deriv-v2 exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv-v2 (addend exp) var)
                   (deriv-v2 (augend exp) var)))
        ((product? exp)
         (make-sum
            (make-product (multiplier exp)
                          (deriv-v2 (multiplicand exp) var))
            (make-product (multiplicand exp)
                          (deriv-v2 (multiplier exp) var))))
        ((exponentiation? exp)
         (make-product (deriv-v2 (base exp) var)
                       (make-product
                         (exponent exp)
                         (make-exponentiation
                            (base exp)
                            (- (exponent exp) 1)))))
        (else
          ; currently, don't support divide, exp and so on..
          (display "unknow expression type "))))
;; end of Exercise 2.56

;; Exercise 2.57
;; update addend, augend, multiplier and multiplicand
;; to support 3 or more element in s expression
(define (augend e)
  (if (null? (cdddr e))
      (caddr e)
      (cons '+ (cddr e))))

(define (multiplicand e)
  (if (null? (cdddr e))
      (caddr e)
      (cons '* (cddr e))))

;; end of Exercise 2.57

;; Exercise 2.58
;; Operator in mid
;; (2 + x)
;;
;; TODO
