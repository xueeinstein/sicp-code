;;; Bill Xue
;;; 2015-10-02
;;; Tree Recursive e.g. Fibonacci array

(define (fib-recur n)
 (cond ((= n 0) 0)
      ((= n 1) 1)
      (else (+ (fib-recur (- n 1))
                (fib-recur (- n 2))))))

(define (fib-iter n)
 (define (iter a b count)
  (if (= count 0)
      b
      (iter (+ a b)
            a
            (- count 1))))

 (iter 1 0 n))
