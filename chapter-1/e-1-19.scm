;;; Bill Xue
;;; 2015-10-03
;;; Fibonacci array with O(lgN)


;; How it works:
;; we define two transform
;; T: a <- a+b, b <- a
;;
;; Tpq: a <- (a+b)q + ap, b <- aq + bp
;;
;; Then we know if p=0, q=1
;; Tpq = T
;;
;; Moreover, we find
;; Tpq^2 = Tp'q', where
;; p' = p^2 + q^2, q' = 2pq + q^2
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (compute-new-p p q)
                   (compute-new-q p q)
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(define (compute-new-p p q)
  (+ (* p p) (* q q)))

(define (compute-new-q p q)
  (+ (* 2 p q) (* q q)))
