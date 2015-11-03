;;; Bill Xue
;;; 2015-11-03
;;; Serializer Implementation

(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      ; acquire mutex and then execute p
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          ; return result of p
          val))
      serialized-p)))

(define (make-mutex)
  (define (test-and-set! cell)
    (if (car cell)
        #f ; already been acquired
        (begin
          ; Attention! test-and-set! should be atomic oper
          ; but we cannot implemente it here
          (set-car! cell #t) ; acquire the mutex
          #f)))

  (define (clear! cell)
    (set-car! cell #f))

  (let ((cell (list #f)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 ; retry =  wait
                 (the-mutex 'acquire)))
            ((eq? m 'release)
             (clear! cell))))
    the-mutex))

;; Exercise 3.46
;; If test-and-set! isn't atomic, one typical way to
;; cause mutex fail is:
; +  P1        mutex      P2
; |  +                     +
; |  |                     |
; |  +--------->#f<--------+
; |  t&s!                 t&s!
; |    +                   +
; |    |                   |
; |    +------> #t <-------+
; |    begin..          begin..
; v
; time

; P1 and P2 both get mutex is available, so they still
; execute parallelly.


;; Exercise 3.47
;; semaphore

;; implementation using busy waiting
(define (make-semaphore n)
  (let ((taken 0)
        (the-mutex (make-mutex)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (the-mutex 'acquire)
             (if (< taken n)
                 (begin
                   (set! taken (+ taken 1))
                   (the-mutex 'release))
                 (begin
                   ; retry
                   (the-mutex 'release)
                   (the-semaphore 'acquire))))
            ((eq? m 'release)
             (the-mutex 'acquire)
             (set! (taken (- taken 1)))
             (the-mutex 'release))))
    the-semaphore))

;; implementation using two mutex to avoid busy waiting
(define (make-semaphore-v2 n)
  (let ((access-mutex (make-mutex))
        (exceeded-mutex (make-mutex))
        (taken 0))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             ; lock to avoid others access taken
             (access-mutex 'acquire)
             (cond ((> taken n)
                    ; unlock the access of taken
                    (access-mutex 'release)
                    ; lock to avoid arrange other semaphores
                    ; also avoid busy waiting
                    (exceeded-mutex 'acquire)
                    ; wait to arrange new semaphores
                    (the-semaphore 'acquire))
                   (else
                    (set! taken (+ taken 1))
                    (if (= taken n)
                        ; already full
                        (exceeded-mutex 'acquire))
                    ; unlock the access of taken
                    (access-mutex 'release))))
            ((eq? m 'release)
             (access-mutex 'acquire)
             (set! taken (- taken 1))
             (access-mutex 'release)
             (exceeded-mutex 'release))))
    the-semaphore))
