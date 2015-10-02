;;; Bill Xue
;;; 2015-10-01
;;; This program shows the special feature of lisp
;;; We can handle process as data in lisp!!!!


(define (a-plus-abs-b a b)
 ((if (> b 0)
   +
   -) ; decide the sign of b
  a b))

(a-plus-abs-b 1 -4)
