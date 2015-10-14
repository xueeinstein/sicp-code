;;; Bill Xue
;;; 2015-10-13
;;; Huffman Tree

;; Represent Huffman tree
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      ; for code-tree
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (decode bits tree)
  (define (decode-l bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
                (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons
                (symbol-leaf next-branch)
                ; restart from the root
                (decode-l (cdr bits) tree))
              (decode-l (cdr bits) next-branch)))))

  (decode-l bits tree))

; help rank the elements in list
; when insert
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set)))
         (cons x set)) ; rank in ascend
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

; init leaf pairs from input
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

;; Exercise 2.67
;; test decode
(define sample-Huffman-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))

(define sample-message
  '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-Huffman-tree)
; get decoded message (A D A B B C A)

;; Exercise 2.68
;; encode
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  ; why not build a symbol-encode dic?
  ; here, in-order
  (define (traverse symbol tree trace)
    (cond ((and (leaf? tree)
                (eq? (symbol-leaf tree)
                     symbol))
           trace)
          ((memq symbol (symbols (left-branch tree)))
           ; symbol in left branch
           (traverse
              symbol
              (left-branch tree)
              (append trace (list 0))))
          ((memq symbol (symbols (right-branch tree)))
           ; symbol in left branch
           (traverse
              symbol
              (right-branch tree)
              (append trace (list 1))))
          (else (error
                  "cannot encode symbol --ENCODE-SYMBOL: "
                  symbol))))

  (traverse symbol tree '()))

;; Exercise 2.69
;; Generate Huffman Tree
(define (generate-huffman-tree pairs)
  (define (successive-merge sub-trees)
    (cond ((null? sub-trees) '())
          ((null? (cdr sub-trees))
           ; already got the Huffman tree
           (car sub-trees))
          (else
            (successive-merge
              (cons (make-code-tree
                      (cadr sub-trees)
                      (car sub-trees))
                    (cddr sub-trees))))))

  (successive-merge (make-leaf-set pairs)))

;; Exercise 2.70
;; Huffman Tree using to compress lyrics
(define lyrics-symbol-pairs
  '((A 2) (NA 16) (BOOM 1) (SHA 3)
    (GET 2) (YIP 9) (JOB 2) (WAH 1)))

(define lyrics
  '(GET A JOB SHA NA NA NA NA NA NA NA NA
    GET A JOB SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
    SHA BOOM))

(define encoded-lyrics
  (encode lyrics
          (generate-huffman-tree lyrics-symbol-pairs)))

; encoded lyrics length is 87 bits
; if using fixed-length code, we need
; 3 * (length lyrics) = 108
(define encoded-lyrics-length
  (length encoded-lyrics))

;; Exercise 2.71
;; The symbols frequence in list
;; 1, 2, 4, ... , 2^(n-1)

;; We can generate the worst (with largest height)
;; binary tree
;; so the short symbol enocde length is 1
;; the longest symbol encode length is n-2

;; Exercise 2.72
;; For unbalanced tree, the total encode is O(n*n)
;; For perfect balanced tree, the total encode is O(nlgn)
