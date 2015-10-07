;;; Bill Xue
;;; 2015-10-07
;;; Repeate procedure n times



(define (repeated f n)
  (define (compose f g)
    (lambda (x)
      (f (g x))))

  (do ((final-procedure f)
       (i 1))
      ((= i n) final-procedure)
      (begin
        (set! final-procedure
          (compose f final-procedure))
        (set! i (+ i 1)))))

(define (test)
  (define (square i)
    (* i i))

  ((repeated square 2) 5))
