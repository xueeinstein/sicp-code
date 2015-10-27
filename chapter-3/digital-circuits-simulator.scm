;;; Bill Xue
;;; 2015-10-26
;;; Digital Circuits Simulator

;;; some basic circuits component
(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (display "@not@ new-value: ")
      (display new-value)
      (newline)
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))

  ; when input changed, trigger invert-input
  (add-action! input invert-input)
  'ok)

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
            (logical-and (get-signal a1) (get-signal a2))))
      (display "@and@ new-value: ")
      (display new-value)
      (newline)
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))

  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

;; Exercise 3.28
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
            (logical-or (get-signal a1) (get-signal a2))))
      (display "@or@ new-value: ")
      (display new-value)
      (newline)
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))

  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

;; end of e-3.28

(define (half-adder a b sum c)
  ; c is carry bit
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e sum)
    'ok))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;; Exercise 3.29
;; Re-implement or-gate using De Morgan's law
;; A U B = ~ ((~ A) ^ (~ B))
(define (or-gate-De-Morgan a1 a2 output)
  (let ((a1-not (make-wire))
        (a2-not (make-wire))
        (a1-a2-not-and (make-wire)))
    (inverter a1 a1-not)
    (inverter a2 a2-not)
    (and-gate a1-not a2-not a1-a2-not-and)
    (inverter a1-a2-not-and output)
    'ok))

; According to fellow implementation
; the or-gate-delay is:
; and-gate-delay + 2 * inverter-delay

;; Exercise 3.30
;; Ripple-carry Adder
(define (ripple-carry-adder a-list b-list s-list c)
  ; c is the final carry-bit
  ; (car s-list) is the final sum
  (let ((c-iter (make-wire)))
    (if (null? a-list)
        ; adden is null, so carry-bit is 0
        (set-signal! c-iter 0)
        (ripple-carry-adder (cdr a-list)
                            (cdr b-list)
                            (cdr s-list)
                            c-iter))
    (full-adder (car a-list)
                (car b-list)
                c-iter
                (car s-list)
                c)))

;; end of e-3.30

;;; primitive function boxes
(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          ; avoid cycle calling
          (begin
            (set! signal-value new-value)
            ; binding signal changes to tigger actions
            (call-each action-procedures))
          ; if signal doesn't change
          ; do nothing!
          'done))

    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))

    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error "Unknown operation -- WIRE" m))))

    dispatch))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin
        ((car procedures))  ; every procedure is non-arg proc
        (call-each (cdr procedures)))))

;; simulation for 'after-delay'
(load "queue.scm")

(define (make-time-segment time queue)
  ; queue is procedures queue
  (cons time queue))

(define (segment-time s) (car s))

(define (segment-queue s) (cdr s))

; agenda is one dimensional table
; saving time segments in time order
(define (make-agenda) (list 0)) ; 0 is current time

(define (current-time agenda) (car agenda))

(define (set-current-time! agenda time)
  (set-car! agenda time))

(define (segments agenda) (cdr agenda))

(define (set-segments! agenda segments)
  (set-cdr! agenda segments))

(define (first-segment agenda)
  (car (segments agenda)))

(define (rest-segments agenda)
  (cdr (segments agenda)))

(define (empty-agenda? agenda)
  (null? (segments agenda)))

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
    (or (null? segments)
        (< time (segment-time (car segments)))))

  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))

  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
        ; found the right time segment
        (insert-queue! (segment-queue (car segments))
                       action)
        ; first segment isn't suitable
        (let ((rest (cdr segments)))
          (if (belongs-before? rest)
              ; insert
              (set-cdr!
                segments
                (cons (make-new-time-segment time action)
                      (cdr segments)))
              ; continue to check next segment
              (add-to-segments! rest)))))

  ; main
  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
        (set-segments!
          agenda
          (cons (make-new-time-segment time action)
                segments))
        (add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        ; also remove this time segment
        (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda (segment-time first-seg))
        (front-queue (segment-queue first-seg)))))

(define (after-delay delay action)
  (add-to-agenda!
    ; get the predict time
    (+ delay (current-time the-agenda))
    action
    the-agenda))

(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
        (first-item) ; call first procedure
        (remove-first-agenda-item! the-agenda)
        (propagate))))

(define the-agenda (make-agenda))

(define logical-or
  (lambda (x y)
    (if (> (+ x y) 0)
        1
        0)))

(define logical-and
  (lambda (x y)
    (if (> (+ x y) 1)
        1
        0)))

(define logical-not
  ; input 0, output 1
  ; input 1, output 0
  (lambda (x)
    (- 1 x)))

(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

; trace the procedures
(trace add-to-agenda!)
(trace after-delay)
(trace or-gate)
(trace and-gate)
(trace inverter)
(trace first-agenda-item)
;; test: probe the half-adder
(define (probe name wire)
  (add-action!
    wire
    (lambda ()
      (newline)
      (display name)
      (display " ")
      (display (current-time the-agenda))
      (display " New-value = ")
      (display (get-signal wire))
      (newline))))

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(probe 'sum sum)
(probe 'carry carry)

(half-adder input-1 input-2 sum carry)

(set-signal! input-1 1)

(propagate)
; result:
; sum 0 New-value = 0
; carry 0 New-value = 0
;
; sum 8 New-value = 1

(set-signal! input-2 1)

(propagate)
; result:
; sum 8 New-value = 1
; carry 11 New-value = 1


;; Exercise 3.31
;; if no init executation in 'accept-action-procedure!'
;; we can only get:
;; carry 11 New-value = 1

;; Exercise 3.32
;; (a1, a2), (0, 1) as input to an and-gate
;;
;; suppose the process is (0 1)->(1 1)->(1 0)
;; Then the output-1 = 1, output-2 = 0
;; If using queue, the final result is output-2, 0
;; If using stack, the final result is output-1, 1, got error
