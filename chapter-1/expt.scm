;;; Bill Xue
;;; 2015-10-02
;;; expt: b^n

(define (expt-normal-recur b n)
  (if (= n 0)
      1
      (* b (expt-normal-recur b (- n 1)))))

(define (expt-normal-iter b n)
  (define (iter b counter product)
    (if (= counter 0)
        product
        (iter b
                (- counter 1)
                (* b product))))  ; end of iter

  (iter b n 1))

(define (fast-expt b n)
  (define (square x) (* x x))

  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))