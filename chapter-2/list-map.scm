;;; Bill Xue
;;; 2015-10-09
;;; List Map

(define (map-me proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map-me (proc (cdr items))))))

;; Exercise 2.21
(define (square-list-old items)
  (if (null? items)
      '()
      (cons ((lambda (i) (* i i)) (car items))
            (square-list-old (cdr items)))))

(define (square-list-new items)
  (map (lambda (i) (* i i)) items))

;; Exercise 2.22
(define (square-reverse-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons ((lambda (i) (* i i)) (car things))
                    answer))))

  (iter items '()))

(define (square-list-iter items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append answer
                      (list ((lambda (i) (* i i))
                             (car things)))))))

  (iter items '()))


;; Exercise 2.23
;; for-each
(for-each (lambda (x) (newline) (display x))
          (list 4 5 6))
