;;; Bill Xue
;;; 2015-10-17
;;; Coercion Convertion in Generic Arithmetic System
;;; to help combine data of different types

(load "put-get.scm")
(load "put-get-coercion.scm")
(load "generic-arithmetic-sys.scm")

;; define coercion procedures
(define (install-coercion-package)
  ; internal procedures
  (define (scheme-number->complex n)
    (make-complex-from-real-imag (contents n) 0))

  ; interface to rest of the system
  (put-coercion 'scheme-number 'complex
                scheme-number->complex)
  'done)

;; overide the basic version of apply-generic
;; from generic-arithmetic-sys.scm
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (if (= (length args) 2)
            (let ((type1 (car type-tags))
                  (type2 (cadr type-tags))
                  (a1 (car args))
                  (a2 (cadr args)))
              (if (equal? type1 type2)    ; Updated
                  (error "No method for these types"
                         (list op type-tags))
                  (let ((t1->t2 (get-coercion type1 type2))
                        (t2->t1 (get-coercion type2 type1)))
                    (cond (t1->t2
                           (apply-generic op (t1->t2 a1) a2))
                          (t2->t1
                           (apply-generic op a1 (t2->t1 a2)))
                          (else
                           (error "No method for these types"
                                  (list op type-tags)))))))
            ; currently only support two args
            (error "No method for these types"
                   (list op type-tags)))))))

;; install new packages
(install-coercion-package)

;; Exercise 2.81
;; a) Obviously, (exp complex1 complex2) causes infinity loop
;; b) As a) showed, Louis crash the program, causes infinity loop
;; c) Updated apply-generic, please check above


;; Exercise 2.82
;; It's hard to provide multiple args operation
;; TODO

;; Exercise 2.83
;; TODO
;; Exercise 2.84
;; TODO
;; Exercise 2.85
;; TODO
