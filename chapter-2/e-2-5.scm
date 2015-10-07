;;; Bill Xue
;;; 2015-10-07
;;; Cons to An Integer
;;; Using 2^a*3^b to represent (cons a b)

;; Method III
(define (cons-v3 a b)
  (* (expt 2 a) (expt 3 b)))

(define (car-v3 z)
  (do ((i 0)
       (rest z))
      ((not (= (remainder rest 2) 0))
       i)
      (begin
          (set! rest (/ rest 2.0))
          (set! i (+ i 1)))))

(define (cdr-v3 z)
  (do ((i 0)
       (rest z))
      ((not (= (remainder rest 3) 0))
       i)
      (begin
          (set! rest (/ rest 3.0))
          (set! i (+ i 1)))))
