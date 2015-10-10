;;; Bill Xue
;;; 2015-10-09
;;; Conventional Interfaces

;; ==============================
;; Analysis Signal-flow structure
;; ==============================

;; Two examples with Signal-flow structure as:
;; enumerate -> filter -> map -> accumulate

;; messed up
(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) ((lambda (i) (* i i)) tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
        '()
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

;; implement different pharse one by one
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; re-implement sum-odd-squares and even-fibs
;; according to Signal-flow structure
(define (sum-odd-squares-new tree)
  (accumulate +
              0
              (map (lambda (i) (* i i))
                   (filter odd?
                           (enumerate-tree tree)))))

(load "../chapter-1/e-1-19.scm") ; load fib
(define (even-fibs-new n)
  (accumulate cons
              '()
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

;;==============================
;; Exercise
;;==============================

;; Exercise 2.33

(define (map-me p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y))
              '()
              sequence))

(define (append-me seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length-me sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;; Exercise 2.34
;; Horner Rule
;; get the value of polynomial
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                  (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

;; Exercise 2.35
;; count-leaves re-implement
(define (count-leaves t)
  (accumulate (lambda (x y) (+ 1 y)) 0 (map enumerate-tree t)))

;; Exercise 2.36
;; seqs e.g. ((1 2) (3 2)), all sub-seq has same length
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init
              ; filter first element in every sub-seq
              (map (lambda (i) (car i)) seqs))
            (accumulate-n op init
              (map (lambda (i) (cdr i)) seqs)))))

;; Exercise 2.37
;; Matrix

;; vector dot product
;; \sum{v_i w_i}
(define (dot-product v m)
  (accumulate + 0 (map * v m)))

(define (matrix-*-vector m v)
  (map (lambda (i) (dot-product v i)) m))

(define (matrix-*-matrix m n)
  (let ((n-transpose (transpose n)))
       (map (lambda (mi)
              (map (lambda (nti) (dot-product mi nti))
                   n-transpose))
            m)))

(define (transpose m)
  (accumulate-n cons '() m))

;; Exercise 2.38
;; fold-left, reverse to accumulate (fold-right)
(define fold-right accumulate)
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))

  (iter initial sequence))

;; Exercise 2.39
;; Reverse
(define (reverse-v1 sequence)
  (fold-right (lambda (x y) (append y (list x))) '() sequence))

(define (reverse-v2 sequence)
  (fold-left (lambda (x y) (append (list y) x)) '() sequence))
