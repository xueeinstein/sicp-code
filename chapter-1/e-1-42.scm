;;; Bill Xue
;;; 2015-10-07
;;; Compose procedure

(define (compose f g)
  (lambda (x)
    (f (g x))))

; test
(define (test)
  (define square (lambda (i) (* i i)))
  (define inc (lambda (i) (+ i 1)))

  ((compose square inc) 6))
