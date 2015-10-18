;;; Bill Xue
;;; 2015-10-17
;;; put-coercion & get-coercion

(load "put-get.scm")

(define coercion-table (make-table))

(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))
