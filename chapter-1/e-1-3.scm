;;; Bill Xue
;;; 2015-10-01
;;; Define a process
;;; Input: 3 args
;;; Output: the max of sum of two args


(define (three-max-sum-two a b c)
 (define sum1 (+ a b))
 (define sum2 (+ a c))
 (define sum3 (+ b c))
 (if (> sum1 sum2)
   (if (> sum1 sum3)
      sum1
      sum3
    )
   (if (> sum2 sum3)
      sum2
      sum3
    )))