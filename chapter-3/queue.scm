;;; Bill Xue
;;; 2015-10-24
;;; Queue

;; To operater Queue in O(1)
;; we design fellow structure:

;          +--+--+
; q +--->  |  |  |
;          ++-+--+----------------+
;           |                     |
;           | front-ptr           | rear-ptr
;          +v-+--+     +--+--+   +v-+--+
;          |  |  +----->  |  +--->  |  |
;          ++-+--+     ++-+--+   ++-+--+
;           |           |         |
;           v           v         v
;           a           b         c

(define (make-queue)
  (cons '() '()))

(define (front-ptr queue)
  (car queue))

(define (rear-ptr queue)
  (cdr queue))

(define (set-front-ptr! queue item)
  (set-car! queue item))

(define (set-rear-ptr! queue item)
  (set-cdr! queue item))

; queue basic operations
(define (empty-queue? queue)
  (null? (front-ptr queue)))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
            ; append
            (set-cdr! (rear-ptr queue) new-pair)
            ; move rear-ptr
            (set-rear-ptr! queue new-pair)
            queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE called with an empty queue" queue))
        (else
          (set-front-ptr! queue
                          (cdr (front-ptr queue)))
          queue)))

;; Exercise 3.21
(define (print-queue queue)
  (define (iter l)
    (if (null? l)
        (begin
          (display ")"))
        (begin
          (if (pair? (car l))
              (begin
                (display "(")
                ; print inner list
                (iter (car l)))
              (display (car l)))
          (if (not (null? (cdr l)))
              ; avoid last space
              (display " "))
          (iter (cdr l)))))

  (begin
    (display "(")
    (iter (front-ptr queue))
    (newline)))

;; Exercise 3.22
;; Another implementation of queue
(define (make-queue-v2)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))

    (define (front-queue)
      (if (empty-queue?)
          (error "FONT called with an empty queue"
                 queue)
          (car front-ptr)))

    (define (insert-queue! item)
      (let ((new-pair (list item)))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr)
              (else
                (set-cdr! rear-ptr new-pair)
                (set! rear-ptr new-pair)
                front-ptr))))

    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE called with an empty queue"
                    queue))
            (else
              (set! front-ptr (cdr front-ptr))
              front-ptr)))

    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            (else
              (error "Unknown operation -- DISPATCH" m))))

    dispatch))

;; Exercise 3.23
;; deque
;; with O(1) complexity,
;; we implemente a double linked list

(define (make-dlink value prev next)
  (cons (cons value prev) next))

(define (value-dlink dlink)
  (car (car dlink)))

(define (next-dlink dlink)
  (cdr dlink))

(define (prev-dlink dlink)
  (cdar dlink))

(define (set-dlink-value! dlink value)
  (set-car! (car dlink)))

(define (set-dlink-prev! dlink prev)
  (set-cdr! (car dlink) prev))

(define (set-dlink-next! dlink next)
  (set-cdr! dlink next))

(define (push-dlink-prev! dlink value)
  (if (not (null? (prev-dlink dlink)))
      ; for middle link
      (error "PUSH-PREV! called on a middle link" dlink)
      (let ((new-pair (make-dlink value '() dlink)))
        (set-dlink-prev! dlink new-pair)
        ; the head ptr changed
        new-pair)))

(define (push-dlink-next! dlink value)
  (if (not (null? (next-dlink dlink)))
      ; for middle link
      (error "PUSH-NEXT! called on a middle link" dlink)
      (let ((new-pair (make-dlink value dlink '())))
        (set-dlink-next! dlink new-pair)
        ; the tail ptr changed
        new-pair)))

;; here we define deque as a (cons head-ptr tail-ptr)
;; of a double linked list
(define (make-deque)
  (cons '() '()))

(define (head-ptr deque)
  (car deque))

(define (tail-ptr deque)
  (cdr deque))

(define (set-head-ptr! deque v)
  (set-car! deque v))

(define (set-tail-ptr! deque v)
  (set-cdr! deque v))

;; deque operations
(define (empty-deque? deque)
  (null? (head-ptr deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (value-dlink (head-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an empty deque" deque)
      (value-dlink (tail-ptr deque))))

(define (front-insert-deque! deque v)
  (if (empty-deque? deque)
      ; insert first dlink
      (let ((new-pair (make-dlink v '() '())))
        (set-head-ptr! deque new-pair)
        (set-tail-ptr! deque new-pair))
      ; merge with origin dlink
      (let ((origin-head-ptr (head-ptr deque)))
        (set-head-ptr!
          deque
          (push-dlink-prev! origin-head-ptr v)))))

(define (rear-insert-deque! deque v)
  (if (empty-deque? deque)
      ; insert first dlink
      (let ((new-pair (make-dlink v '() '())))
        (set-head-ptr! deque new-pair)
        (set-tail-ptr! deque new-pair))
      ; merge with origin dlink
      (let ((origin-tail-ptr (tail-ptr deque)))
        (set-tail-ptr!
          deque
          (push-dlink-next! origin-tail-ptr v)))))

(define (front-delete-deque! deque)
  (if (empty-deque? deque)
      (error "DELETE called with an empty deque" deque)
      (begin
        (set-head-ptr!
          deque
          (next-dlink (head-ptr deque)))
        (set-dlink-prev! (head-ptr deque) '()))))

(define (rear-delete-deque! deque)
  (if (empty-deque? deque)
      (error "DELETE called with an empty deque" deque)
      (begin
        (set-tail-ptr!
          deque
          (prev-dlink (tail-ptr deque)))
        (set-dlink-next! (tail-ptr deque) '()))))

;; test:
(define dq (make-deque))
(front-insert-deque! dq 'a)
(front-insert-deque! dq 'b)
(front-insert-deque! dq 'c)
(rear-deque dq) ; get a
(rear-delete-deque! dq)
(rear-deque dq) ; get b
(front-insert-deque! dq 'e)
(front-deque dq) ; get e
(front-delete-deque! dq)
(front-deque dq) ; get c
(rear-insert-deque! dq 'f)
(rear-deque dq) ; get f

