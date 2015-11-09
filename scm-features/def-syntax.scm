;;; Bill Xue
;;; 2015-11-09
;;; Defining Syntax

(define-syntax nil!
  (syntax-rules ()
    ((_ x)
     (set! x '()))))

(define-syntax when
  (syntax-rules ()
    ((_ pred b1 ...)
     (if pred
         (begin
           b1 ...)))))

(define-syntax while
  (syntax-rules ()
    ((_ pred b1 ...)
     (let loop () (when pred b1 ... (loop))))))

(define-syntax for
  (syntax-rules ()
    ((_ (i from to) b1 ...)
     (let loop ((i from))
       (when (< i to)
         b1 ...
         (loop (+ i 1)))))))

(define-syntax incf
  (syntax-rules ()
    ((_ x)
     (begin
       (set! x (+ x 1))
       x))
    ((_ x i)
     (begin
       (set! x (+ x i))
       x))))

;; Recusive definition of syntax
(define-syntax my-and
  (syntax-rules ()
    ((_) #t)
    ((_ e) e)
    ((_ e1 e2 ...)
     (if e1
         (my-and e2 ...)
         #f))))

(define-syntax my-or
  (syntax-rules ()
    ((_) #f)
    ((_ e) e)
    ((_ e1 e2 ...)
     (let ((t e1))
       (if t t (my-or e2 ...))))))

;; Using reserved words in your syntax
(define-syntax my-cond
  (syntax-rules (else)
    ((_ (else e1 ...))
     (begin e1 ...))
    ((_ (e1 e2 ...))
     (when e1 e2 ...))
    ((_ (e1 e2 ...) c1 ...)
     (if e1
         (begin e2 ...)
         (cond c1 ...)))))

;; define local syntax
(define (local-syntax-eg)
  (define a 1)
  (let-syntax ((plus-two! (syntax-rules ()
                            ((_ x)
                             (begin
                               (set! x (+ x 2))
                               x)))))
    (begin
      (display "origin a: ")
      (display a)
      (newline)
      (display "new a: ")
      (display (plus-two! a))
      (newline))))

;; implementation depending macro definition
;;
;; for MIT-scheme, the 'sc-macro-transformer' is available
;; Others TBD