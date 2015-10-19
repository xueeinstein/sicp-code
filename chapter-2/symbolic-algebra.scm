;;; Bill Xue
;;; 2015-10-18
;;; Symbolic Algebra

;; supplementary procedures
(define (variable? x)
  "is x a variable?"
  (symbol? x))

(define (=number? exp num)
  "check whether exp is expression and equal to num"
  (and (number? exp) (= exp num)))

(define (same-variable? v1 v2)
  "are v1 and v2 the same variable?"
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

;; load original generic arithmetic-sys with coercion
(load "coercion-convert-gas.scm")

(define (install-polynomial-package)
  ; internal procedures
  ; representation of polynomial
  (define (make-poly variable term-list)
    (cons variable term-list))

  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  ; representation of terms and term lists
  (define (adjoin-term new-term term-list)
    (if (=zero? (coeff new-term))
        term-list
        (cons new-term term-list)))

  (define (make-term order coeff)
    (list order coeff))

  (define (coeff term)
    (cadr term))
  (define (order term)
    (car term))

  (define (empty-termlist? term-list)
    (null? term-list))

  (define (first-term term-list)
    (car term-list))

  (define (rest-terms term-list)
    (cdr term-list))

  (define the-empty-termlist '())

  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1))
                 (t2 (first-term L2)))
              (cond ((> (order t1) (order t2))
                     (adjoin-term
                        t1 (add-terms (rest-terms L1) L2)))
                    ((< (order t1) (order t2))
                     (adjoin-term
                        t2 (add-terms L1 (rest-terms L2))))
                    (else
                     (adjoin-term
                        (make-term (order t1)
                                   (add (coeff t1) (coeff t2)))
                        (add-terms (rest-terms L1)
                                   (rest-terms L2)))))))))

  (define (sub-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1))
                 (t2 (first-term L2)))
              (cond ((> (order t1) (order t2))
                     (adjoin-term
                        t1 (sub-terms (rest-terms L1) L2)))
                    ((< (order t1) (order t2))
                     (adjoin-term
                        ; minus t2
                        (make-term (order t2)
                                   (- (coeff t2)))
                        (sub-terms L1 (rest-terms L2))))
                    (else
                     (adjoin-term
                        (make-term (order t1)
                                   (sub (coeff t1) (coeff t2)))
                        (sub-terms (rest-terms L1)
                                   (rest-terms L2)))))))))

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        the-empty-termlist
        (add-terms (mul-term-by-all-terms
                      (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        the-empty-termlist
        (let ((t2 (first-term L)))
          (adjoin-term
            (make-term (+ (order t1) (order t2))
                       (mul (coeff t1) (coeff t2)))
            (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
        ; return quotient and remainder
        (list the-empty-termlist the-empty-termlist)
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
              (list the-empty-termlist L1)
              (let ((new-c (div (coeff t1) (coeff t2)))
                    (new-o (- (order t1) (order t2))))
                (let ((rest-of-L1
                        (sub-terms L1
                           (mul-terms
                              (list (make-term new-o new-c))
                              L2))))
                  (let ((rest-of-result
                          (div-terms rest-of-L1 L2)))
                    ; get final result
                    (append
                      (list
                        (adjoin-term
                          (make-term new-o new-c)
                          (car rest-of-result)))
                      (cdr rest-of-result)))))))))

  (define (terms-zero? terms)
    (if (null? terms)
        #t
        ; use '=zero?' so it can check poly recursively
        (and (=zero? (coeff (first-term terms)))
             (terms-zero? (rest-terms terms)))))

  ;; top level operations
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))

  ;; Exercise 2.88
  ;; Add new operation 'sub'
  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (sub-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- SUB-POLY"
               (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))

  ;; Exercise 2.91
  ;; add new operation 'div-poly'
  ;; returen value e.g.
  ;; (polynomial x ((3 1) (1 1)) ((1 1) (0 -1)))
  ;; (polynomial variable quotient remainder)
  (define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (div-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- DIV-POLY"
               (list p1 p2))))

  ;; Exercise 2.87
  ;; =zero? plugin package
  ;; support polynomial
  (define (polynomial-zero? p)
    (terms-zero? (term-list p)))


  ; interface to rest of the system
  (define (tag p)
    (attach-tag 'polynomial p))

  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))

  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))

  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))

  (put 'div '(polynomial polynomial)
       (lambda (p1 p2) (tag (div-poly p1 p2))))

  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))

  (put '=zero? '(polynomial) polynomial-zero?)
  (trace div-terms)
  'done)

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))

;; install package
(install-polynomial-package)

;; Exercise 2.89
;; Exercise 2.90
;; The approach is quite similar to
;; generic data-directed complex
;; so ignore these two exercises

;; Exercise 2.92
;; TODO
;; To support polynomial operations for different variables
;; we need to re-design whole system with special coercion

