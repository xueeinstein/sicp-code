;;; Bill Xue
;;; 2015-10-09
;;; Representing Tree using list

;; e.g.
;; ((1 2) 3 4)
;;     ___
;;    /\  \
;;   /  \  \
;;  /\   \  \
;; /  \   \  \
;;1    2   3  4

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1) ; x is just a num
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

;; Exercise 2.24
;; Too Simple, pass

;; Exercise 2.25
(define l1 '(1 3 (5 7) 9))
(define l2 '((7)))
(define l3 '(1 (2 (3 (4 (5 (6 7)))))))

;; get 7
(car (cdr (car (cdr (cdr l1)))))
(car (car l2))
(car (cdr
     (car (cdr
     (car (cdr
     (car (cdr
     (car (cdr
     (car (cdr l3))))))))))))

;; Exercise 2.26
(define x (list 1 2 3))
(define y (list 4 5 6))
(append x y) ; return (1 2 3 4 5 6)
(cons x y)   ; return ((1 2 3) 4 5 6)
(list x y)   ; return ((1 2 3) (4 5 6))

;; Exercise 2.27
;; deep-reverse
;; e.g.
;; input: ((1 2) (3 4) 5)
;; output: (5 (4 3) (2 1))
(define (deep-reverse l)
  (cond ((null? l) '())
        ((not (pair? l)) l)
        (else
          (append (deep-reverse (cdr l))
                  (list (deep-reverse (car l)))))))

;; Exercise 2.28
;; fringe
;; e.g.
;; input: ((1 2) (3 4) 5)
;; output: (1 2 3 4 5)
(define (fringe l)
  (cond ((null? l) '())
        ((not (pair? l)) (list l))
        (else
          (append
            (fringe (car l))
            (fringe (cdr l))))))

;; Exercise 2.29

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  ; Be Careful!
  ; it's easy to write to '(cdr mobile)'
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (define (branch-weight branch)
    (if (not (pair? (branch-structure branch)))
        (branch-structure branch)
        (total-weight (branch-structure branch))))
  ; main
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (mobile-balance? mobile)
  (define (branch-moment branch)
    (if (not (pair? (branch-structure branch)))
        (* (branch-length branch)
           (branch-structure branch))
        (* (branch-length branch)
           (total-weight (branch-structure branch)))))

  ; TODO, check every sub-mobile balance
  (= (branch-moment (left-branch mobile))
     (branch-moment (right-branch mobile))))

;;;;;;;;;;;;;;;;
;; Map Tree
;;;;;;;;;;;;;;;;

(define (scale-tree tree factor)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(define (scale-tree-map tree factor)
  (map (lambda (sub-tree)
          (if (pair? sub-tree)
              (scale-tree-map sub-tree factor)
              (* sub-tree factor)))
       tree))

;; Exercise 2.30
(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* tree tree))
        (else
          (cons (square-tree (car tree))
                (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (sub-tree)
          (if (pair? sub-tree)
              (square-tree-map sub-tree)
              (* sub-tree sub-tree)))
       tree))

;; Exercise 2.31
;; Tree Map Abstract Procedure
(define (tree-map proc tree)
  (map (lambda (sub-tree)
          (if (pair? sub-tree)
              (tree-map proc sub-tree)
              (proc sub-tree)))
       tree))

(define (square-tree-new tree)
  (tree-map (lambda (i) (* i i)) tree))

;; Exercise 2.32
;; Subsets
(define (subsets s)
  (if (null? s)
      (list '()) ; Be Careful! Not '()
      (let ((rest (subsets (cdr s))))
        ; rest is subsets of s without (car s)
        (append rest
                (map (lambda (i) (cons (car s) i)) rest)))))
