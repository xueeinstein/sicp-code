;;; Bill Xue
;;; 2015-10-02
;;; Yanghui Triangle

;; 1
;; 1 1
;; 1 2 1
;; 1 3 3 1
;; 1 4 6 4 1
;; ....

;; when i>1, 0<j<i
;; a_{i, j} = a_{i-1, j} + a_{i-1, j-1}
;;
;; a_{i, 0} = 1
;; a_{i, i} = 1
;;
;; when i>j
;; a{i, j} = 0

(define (Yanghui-Triangle index-i index-j)
 (cond ((< index-i index-j) 0)
       ((= index-i index-j) 1)
       ((= index-j 0) 1)
       (else
          (+
            (Yanghui-Triangle
              (- index-i 1)
              index-j)
            (Yanghui-Triangle
              (- index-i 1)
              (- index-j 1))))))

;; print n-level Yanghui-Triangle
(define (print-Yanghui-Triangle n-level)
 (define (iter counter)
  (if (<= counter n-level)
      (begin
          (iter-sub counter)
          (iter (+ counter 1)))))

 (define (iter-sub counter)
  (begin
      (print-nth-line counter)
      (newline)))

 ; print line 'size'(start from 0)
 (define (print-nth-line nth)
  (do ((vec (make-vector (+ nth 1)))
       (i 0 (+ i 1)))
      ((= i (+ nth 1)) vec) ; when i=size, return vec
    (begin (vector-set! vec i (Yanghui-Triangle nth i))
           (print (Yanghui-Triangle nth i))
           (print " ")
     )))

 (iter 0))

;(time (print-Yanghui-Triangle 10))
