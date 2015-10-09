;;; Bill Xue
;;; 2015-10-09
;;; Variable Procedure Parameters

(define (same-parity x . y)
  ; filter even or odd in list y
  (define (filter-eo eo? l)
    (do ((i 0)
         (filtered-l '())
         (n (length l)))
        ((= i n) filtered-l)
        (begin
          ; alternatively, we can use 'for-each'
          (let ((now (list-ref l i)))
              (if (eo? now)
                  (set! filtered-l
                        (append filtered-l (list now)))))
          (set! i (+ i 1)))))

  ; more lispship version filter-eo
  (define (filter-eo-update eo? l)
    (if (null? l)
        '()
        (append ((lambda (i)
                  (if (eo? i)
                      (list i)
                      '()))
                 (car l))
                (filter-eo-update eo? (cdr l)))))

  ; main
  (if (even? x)
      (append (list x) (filter-eo-update even? y))
      (append (list x) (filter-eo-update odd? y))))
      ;(append (list x) (filter-eo even? y))
      ;(append (list x) (filter-eo odd? y))))
