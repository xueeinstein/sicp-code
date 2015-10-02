;;; Bill Xue
;;; 2015-10-01
;;; Linear iterative and recursive

(define (factorial-recur n)
 (if (= n 1)
  1
  (* n (factorial-recur (- n 1)))))

(define (factorial-iter n)
 (define (iter product counter)
  (if (> counter n)
   product
   (iter (* product counter)
        (+ counter 1))))

 (iter 1 1))
