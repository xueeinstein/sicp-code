;;; Bill Xue
;;; 2015-10-08
;;; List Operations


;; Even we can rewrite cons, car and cdr in lisp!
(define (cons-me x y)
  (lambda (m) (m x y)))

(define (car-me z)
  (z (lambda (p q) p)))

(define (cdr-me z)
  (z (lambda (p q) q)))

; TODO
;(define (list-me

;; Some higher level list operations
(define (list-ref-me iterms n)
  (if (= n 0)
      (car iterms)
      (list-ref-me (cdr iterms) (- n 1))))

(define (length-me iterms)
  (if (null? iterms)
      0
      (+ 1 (length-me (cdr iterms)))))

(define (append-me list1 list2)
  (if (null? list1)
      list2
      (cons (car list1)
            (append-me (cdr list1) list2))))

;; Exercise 2.17
(define (last-pair iterms)
  (cond ((null? iterms) (list))
        ((null? (cdr iterms)) (list (car iterms)))
        (else (last-pair (cdr iterms)))))

;; Exercise 2.18
(define (reverse-me iterms)
  (if (null? iterms)
      (list)
      (append (reverse-me (cdr iterms)) (list (car iterms)))))

