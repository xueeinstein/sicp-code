;;; Bill Xue
;;; 2015-10-07
;;; Church Counting

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; Summary:
;; (add-1 zero) got procedure 'one'
;; (lambda (f) (lambda (x) (f x)))
;;
;; (add-1 one) got procedure 'two'
;; (lambda (f) (lambda (x) (f (f x))))

(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (add a b)
  ; in the way which we can generate structure
  ; (f (f .. (f x))..), (total a+b f)
  (lambda (f) (lambda (x) ((b f) ((a f) x)))))
