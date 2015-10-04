;;; Bill Xue
;;; 2015-10-03
;;; convert * to +

(define (* a b)
  (print ".") ; trace recurse
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

(print (* 2 3))
