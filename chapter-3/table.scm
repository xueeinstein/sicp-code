;;; Bill Xue
;;; 2015-10-25
;;; Table

;;; one dimension table

; table
;   +
;   |
;  +v-+--+    +--+--+   +--+--+
;  |  |  +---->  |  +--->  |  |
;  ++-+--+    ++-+--+   +-++--+
;   |          |          |
;   v          |          |
;             +v-+--+   +-v+--+
; *table*     |  |  |   |  |  |
;             ++-++-+   ++-++-+
;              |  |      |  |
;              v  v      v  v
;              a  1      b  2

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))

(define (assoc-me key records)
  (cond ((null? records) #f)
        ; here using equal?
        ; symbol, num and list are allowed
        ((equal? key (caar records))
         (car records))
        (else (assoc-me key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        ; update this item
        (set-cdr! record value)
        ; insert new item
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table)))))
  'ok)

(define (make-table)
  (list '*table*))

;; test:
(define t (make-table))
(insert! 'a 1 t)
(insert! 'b 2 t)
(lookup 'a t) ; get 1
(lookup 'c t) ; get #f

;;; two dimension table

; table
;   +
;   |
;  +v-+--+    +--+--+   +--+--+
;  |  |  +---->  |  +--->  |  |
;  ++-+--+    ++-+--+   ++-+--+
;   |          |         |
;   v          |        +v-+--+   +--+--+
; *table*      |        |  |  +--->  |  |
;              |        ++-+--+   +-++--+
;      +-------+         |          |
;      |                 v        +-v+--+
;      |                 letters  |  |  |
;    +-v+--+    +--+--+           ++-+-++
;    |  |  +---->  |  |            v   v
;    +-++--+    +-++--+            a   97
;      v          |
;    math       +-v+--+
;               |  |  |
;               +-++-++
;                 v  v
;                 +  43

(define (lookup-2d-table key-1 key-2 table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record
              (cdr record)
              #f))
        #f)))

(define (insert-2d-table! key-1 key-2 value table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        ; no need to create new subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record
              ; update the item
              (set-cdr! record value)
              ; insert new item at front
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
        ; create new subtable
        (set-cdr! table
                  (cons (list key-1
                              (cons key-2 value))
                        (cdr table)))))
  'ok)

;; make-2d-table share the same procedure with
;; make-table
;;
;; test:
(insert-2d-table! 'letters 'a 97 t)
(insert-2d-table! 'math '+ 43 t)
(lookup-2d-table 'math '+ t)  ; get 43
(lookup-2d-table 'letters 'b t)  ; get #f

;;; Use local table to handle multiple tables
;;; simultaneously
(define (make-local-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))

    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc) insert!)
            (else
              (error "Unknown operation -- TABLE" m))))
    dispatch))

;; Exercise 3.24
;; Approximation in Table
;; Lookup item according to customized rule, not 'equal?'
(define (make-customized-table same-key?)
  (let ((local-table (list '*table*)))
    (define (assoc-customized key records)
      (cond ((null? records) #f)
            ; here, customized!
            ((same-key? key (caar records))
             (car records))
            (else
              (assoc-customized key (cdr records)))))

    (define (lookup key-1 key-2)
      (let ((subtable (assoc-customized
                        key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc-customized
                            key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))

    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc-customized
                        key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc-customized
                            key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc) insert!)
            (else
              (error "Unknown operation -- TABLE" m))))
    dispatch))

;; Exercise 3.25
;; Variable Dimensional Table
(define (make-variable-table)
  (let ((local-table (list '*table*)))
    (define (lookup keys)
      ; keys is a list of key
      (if (null? keys)
          #f
          (lookup-iter local-table keys)))

    (define (lookup-iter table keys)
      (cond ((and (not (null? table)) (null? keys))
             (cdr table))
            ((null? keys) #f)
            (else
              (let ((subtable (assoc (car keys)
                                     (cdr table))))
                (if subtable
                    (lookup-iter subtable (cdr keys))
                    #f)))))

    (define (insert! keys value)
      ; keys is a list of key
      (if (null? keys)
          (error "INSERT without keys" keys)
          (insert-iter! local-table keys value)))

    (define (insert-iter! table keys value)
      (cond ((null? table)
             ; alreay guarantee keys not null
             ; when calls insert-iter!
             'error)
            (else
              (let ((subtable (assoc (car keys)
                                     (cdr table))))
                (if subtable
                    (if (null? (cdr keys))
                        ; update the item
                        (set-cdr! subtable value)
                        ; recursively insert the item
                        (insert-iter! subtable (cdr keys) value))
                    ; the first key doesn't exist
                    (if (null? (cdr keys))
                        ; insert new iterm
                        (set-cdr! table
                                  (cons
                                    (cons (car keys) value)
                                    (cdr table)))
                        (begin
                          ; insert a null subtable
                          (set-cdr! table
                                    (cons
                                      (list (car keys))
                                      (cdr table)))
                          ; recursively insert the item
                          (insert-iter! (cadr table)
                                        (cdr keys)
                                        value))))))))

    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            ; add print for debug
            ((eq? m 'print) local-table)
            (else
              (error "Unknown operation -- TABLE" m))))
    dispatch))

;; test:
(define t (make-variable-table))
((t 'insert!) '(a) 1)
((t 'insert!) '(b) 2)
((t 'insert!) '(d e f) 3)
((t 'lookup) '(d e f)) ; get 3
((t 'lookup) '(b)) ; get 2
((t 'insert!) '(b) 4) ; update value of b
((t 'lookup) '(b)) ; get 4

;; Exercise 3.26
;; BST table
;;

;; BST, entry is (key . value) pair
;; follow key alphabetical order
(define (make-bst entry left right)
  (list entry left right))

(define (is-bst? l)
  (and (pair? l) (= (length l) 3)))

(define (empty-bst? tree)
  ; just check wheter root is null?
  (null? (entry tree)))

(define (entry tree)
  (car tree))

(define (key entry)
  (car entry))

(define (value entry)
  (cdr entry))

(define (set-value! entry new-value)
  (set-cdr! entry new-value))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (compare-key m)
  (define (num-symbol->string key)
    (cond ((number? key)
           (number->string key))
          ((symbol? key)
           (symbol->string key))
          (else
            (error "Unknown key -- COMPARE-KEY" key))))

  (lambda (key-1 key-2)
    (let ((str-1 (num-symbol->string key-1))
          (str-2 (num-symbol->string key-2)))
      (cond ((eq? m '=) (string=? str-1 str-2))
            ((eq? m '<) (string<? str-1 str-2))
            ((eq? m '>) (string>? str-1 str-2))
            (else (error "Unknown operation -- COMPARE-KEY"
                         m))))))

(define (adjoin-bst-set x set)
  (cond ((or (null? set) (empty-bst? set))
         (make-bst x '() '()))
        (((compare-key '=)
            (key x) (key (entry set)))
         set)
        (((compare-key '<)
            (key x) (key (entry set)))
         (make-bst (entry set)
                   (adjoin-bst-set x (left-branch set))
                   (right-branch set)))
        (((compare-key '>)
            (key x) (key (entry set)))
         (make-bst (entry set)
                   (left-branch set)
                   (adjoin-bst-set x (right-branch set))))))

(define (search-bst query-key tree)
  (cond ((null? tree) #f) ; left or right branch can be nil
        ((empty-bst? tree) #f)
        (((compare-key '=)
            query-key (key (entry tree)))
         ; find and return entry
         (entry tree))
        (((compare-key '<)
            query-key (key (entry tree)))
         (search-bst query-key (left-branch tree)))
        (((compare-key '>)
            query-key (key (entry tree)))
         (search-bst query-key (right-branch tree)))))

;; re-implement variable dimensional table
;;
;; every level of table is like:
;; (cons table-symbol binary-search-tree)
;; or (cons key-symbol value)
(define (make-variable-bst-table)
  (let ((local-table (list '*table*)))
    (define (lookup keys)
      (if (null? keys)
          #f
          (lookup-iter local-table keys)))

    (define (lookup-iter table keys)
      (cond ((and (not (is-bst? (cdr table)))
                  (null? keys))
             (cdr table))
            ((null? keys) #f)
            (else
              (if (is-bst? (cdr table))
                  (let ((subtable (search-bst (car keys)
                                              (cdr table))))
                    (if subtable
                        (lookup-iter subtable (cdr keys))
                        #f))
                  ; alreay found before match all keys
                  #f))))

    (define (insert! keys value)
      ; keys is a list of key
      (if (null? keys)
          (error "INSERT without keys" keys)
          (insert-iter! local-table keys value)))

    (define (insert-iter! table keys value)
      (if (is-bst? (cdr table))
          (let ((subtable (search-bst (car keys)
                                      (cdr table))))
            (if subtable
                (if (null? (cdr keys))
                    (if (is-bst? (cdr subtable))
                        (error "Trying to reset whole subtable"
                               subtable)
                        (set-cdr! subtable value))
                    (insert-iter! subtable (cdr keys) value))
                ; not found (car keys)
                ; we need to insert it into bst
                (let ((new-entry (list (car keys))))
                  (set-cdr! table
                            (adjoin-bst-set new-entry
                                            (cdr table)))
                  (insert-iter! table keys value))))
          ; here (cdr table) can be null or value
          (if (null? (cdr table))
              (begin
                (set-cdr! table (make-bst '() '() '()))
                (insert-iter! table keys value))
              (let ((cond-1 (eq? (car table) (car keys)))
                    (cond-2 (null? (cdr keys))))
                (cond ((and cond-1 cond-2)
                       (set-cdr! table value))
                      ((not cond-1)
                       ; this cond couldn't exist
                       ; other procedure guarantee it
                       'error)
                      ((and cond-1 (not cond-2))
                       (error
                          "Trying to convert value to subtable"
                          table)))))))

    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            ; add print for debug
            ((eq? m 'print) local-table)
            (else
              (error "Unknown operation -- TABLE" m))))

    dispatch))

;; test:
(define bst-t (make-variable-bst-table))
((bst-t 'insert!) '(a) 1)
((bst-t 'insert!) '(b c) 2)
((bst-t 'lookup) '(a)) ; get 1
((bst-t 'lookup) '(b c)) ; get 2
((bst-t 'insert!) '(b c) 3)
((bst-t 'lookup) '(b c)) ; get 3
