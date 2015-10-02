;;; Bill Xue
;;; 2015-10-02
;;; Implementation of function f
;;; when n < 3, f(n) = n
;;; when n >= 3, f(n) = f(n-1) + 2f(n-2) + 3f(n-3)

(define (f-recur n)
 (if (< n 3)
     n
     (+
        (f-recur (- n 1))
        (* (f-recur (- n 2)) 2)
        (* (f-recur (- n 3)) 3))))

(define (f-iter n)
 ; use size-3-queue to save f(n-1), f(n-2) and f(n-3)
 (define size-3-queue (list 0 1 2))

 ; push the new value into queue
 ; keep it size 3
 (define (push x)
  (let ((tmp-queue (append size-3-queue (list x))))
      (set! size-3-queue (list-tail tmp-queue 1))))

 (define (fn)
  (+
    (list-ref size-3-queue 2)
    (* (list-ref size-3-queue 1) 2)
    (* (list-ref size-3-queue 0) 3)))

 (define (iter f counter)
  ; assuming counter >= 3
  (push f)
  (if (= counter n)
      f
      (iter (fn) (+ counter 1))))

  ;==============================
  (if (< n 3)
      n
      (iter (fn) 3)))
