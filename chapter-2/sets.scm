;;; Bill Xue
;;; 2015-10-13
;;; Sets Representing

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ; here must be 'equal?' not 'eq'
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

;; O(n^2)
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;; Exercise 2.59
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (adjoin-set (car set1)
                          (union-set (cdr set1) set2)))))

;; Exercise 2.60
;; Too Simple, passed

;;; Ordered sequence representing sets
(define (element-of-ordered-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-ordered-set? x (cdr set)))))

;; O(n)
(define (intersection-ordered-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-ordered-set
                          (cdr set1)
                          (cdr set2))))
              ((< x1 x2)
               (intersection-ordered-set
                 (cdr set1) set2))
              ((> x1 x2)
               (intersection-ordered-set
                 set1 (cdr set2)))))))

;; Exercise 2.61
(define (adjoin-ordered-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set)
                    (adjoin-ordered-set x (cdr set))))))

;; Exercise 2.62
(define (union-ordered-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
          (let ((x1 (car set1))
                (x2 (car set2)))
            (cond ((= x1 x2)
                   (cons x1 (union-ordered-set
                              (cdr set1)
                              (cdr set2))))
                  ((< x1 x2)
                   (cons x1 (union-ordered-set
                              (cdr set1)
                              set2)))
                  ((> x1 x2)
                   (cons x2 (union-ordered-set
                              set1
                              (cdr set2)))))))))

;;; Representing Ordered sets into
;;; binary search tree

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-bst-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-bst-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-bst-set? x (right-branch set)))))

(define (adjoin-bst-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-bst-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-bst-set x (right-branch set))))))

;; Exercise 2.63
;; BST traverse
;; equal to transforing tree to list

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list
          (left-branch tree)
          (cons (entry tree)
                (copy-to-list (right-branch tree)
                              result-list)))))

  (copy-to-list tree '()))

; three tree in img 2-16
(define tree-a '(7 (3 (1 () ()) (5 () ()))
                   (9 () (11 () ()))))

(define tree-b '(3 (1 () ())
                   (7 (5 () ())
                      (9 () (11 () ())))))

(define tree-c '(5 (3 (1 () ()) ())
                   (9 (7 () ()) (11 () ()))))

; test in tree a using both
; tree->list-1 and tree->list-2
; got the same result-list (in-order traverse)

; TODO: analysis the cost of tree->list-1 and
; tree->list-2 deeply
; In brief, the method 2 replace all
; append (O(n)) operation by cons (O(1))
; so method 1, O(n log(n))
; method 2, O(n)


;; Exercise 2.64
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  "generate balanced BST from first n elements in elts"
  (if (= n 0)
      ; return value: (bst, rest elements)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree
                                  (cdr non-left-elts)
                                  right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree
                        this-entry left-tree right-tree)
                      remaining-elts))))))))

; cost analysis:
; f(n) = 2f(n/2) + O(1), so f(n) = O(n)

;; Exercise 2.65
;; Rewrite union-set and intersection-set
;; based on balanced BST
;; TODO: union two balanced BST in O(n)


;; Exercise 2.66
(define (lookup-bst given-key set-of-records-bst)
  (define key car)
  (define value cadr)
  (cond ((null? set-of-records-bst) #f)
        ((equal? given-key (key (entry set-of-records-bst)))
         (value (entry set-of-records-bst)))
        ((> given-key (key (entry set-of-records-bst)))
         (lookup-bst given-key
                     (right-branch set-of-records-bst)))
        ((< given-key (key (entry set-of-records-bst)))
         (lookup-bst given-key
                     (left-branch set-of-records-bst)))))

; test
(define (adjoin-bst-set-kvpair x set)
  (define key car)
  (cond ((null? set) (make-tree x '() '()))
        ((= (key x) (key (entry set))) set)
        ((< (key x) (key (entry set)))
         (make-tree (entry set)
                    (adjoin-bst-set-kvpair x (left-branch set))
                    (right-branch set)))
        ((> (key x) (key (entry set)))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-bst-set-kvpair x (right-branch set))))))
(define fake-db '())
(set! fake-db (adjoin-bst-set-kvpair '(7 "John") fake-db))
(set! fake-db (adjoin-bst-set-kvpair '(3 "Mary") fake-db))
(set! fake-db (adjoin-bst-set-kvpair '(1 "Peter") fake-db))
(set! fake-db (adjoin-bst-set-kvpair '(5 "Jack") fake-db))
(set! fake-db (adjoin-bst-set-kvpair '(19 "Tom") fake-db))

(lookup-bst 1 fake-db) ; get "Peter"
(lookup-bst 5 fake-db) ; get "Jack"
