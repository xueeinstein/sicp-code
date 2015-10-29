;;; Bill Xue
;;; 2015-10-28
;;; Constraint Network

;;; Implementation of Constraint System

;; adder constraint
(define (adder a1 a2 sum)
  (define (process-new-value)
    (cond ((and (has-value? a1) (has-value? a2))
           (set-value! sum
                       (+ (get-value a1)
                          (get-value a2))
                       me))
          ((and (has-value? a1) (has-value? sum))
           (set-value! a2
                       (- (get-value sum)
                          (get-value a1))
                       me))
          ((and (has-value? a2) (has-value? sum))
           (set-value! a1
                       (- (get-value sum)
                          (get-value a2))
                       me))))

  (define (process-forget-value)
    (forget-value! sum me)
    (forget-value! a1 me)
    (forget-value! a2 me)
    (process-new-value))

  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
            (error "Unknown request -- ADDER" request))))

  (connect a1 me)
  (connect a2 me)
  (connect sum me)
  me)

;; multiplier constraint
(define (multiplier m1 m2 product)
  (define (process-new-value)
    (cond ((or (and (has-value? m1) (= (get-value m1) 0))
               (and (has-value? m2) (= (get-value m2) 0)))
           (set-value! product 0 me))
          ((and (has-value? m1) (has-value? m2))
           (set-value! product
                       (* (get-value m1)
                          (get-value m2))
                       me))
          ((and (has-value? product) (has-value? m1))
           (set-value! m2
                       (/ (get-value product)
                          (get-value m1))
                       me))
          ((and (has-value? product) (has-value? m2))
           (set-value! m1
                       (/ (get-value product)
                          (get-value m2))
                       me))))

  (define (process-forget-value)
    (forget-value! product me)
    (forget-value! m1 me)
    (forget-value! m2 me)
    (process-new-value))

  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
            (error "Unknown request -- MULTIPLIER" request))))

  (connect m1 me)
  (connect m2 me)
  (connect product me)
  me)

;; constant constraint
(define (constant value connector)
  (define (me request)
    (error "Unknown request -- CONSTANT" request))

  (connect connector me)
  (set-value! connector value me)
  me)

;; expose constraint interface
(define (inform-about-value constraint)
  (constraint 'I-have-a-value))

(define (inform-about-no-value constraint)
  (constraint 'I-lost-my-value))

;; make probe
(define (probe name connector)
  (define (print-probe value)
    (newline)
    (display "Probe: ")
    (display name)
    (display " = ")
    (display value))

  (define (process-new-value)
    (print-probe (get-value connector)))

  (define (process-forget-value)
    (print-probe "?"))

  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
            (error "Unknown request -- PROBE" request))))

  (connect connector me)
  me)

;; make connector
(define (make-connector)
  (let ((value #f) (informant #f) (constraints '()))
    (define (set-my-value newval setter)
      (cond ((not (has-value? me))
             (set! value newval)
             (set! informant setter)
             (for-each-except setter
                              inform-about-value
                              constraints))
            ((not (= value newval))
             (error "Contradiction" (list value newval)))
            (else 'ignored)))

    (define (forget-my-value retractor)
      (if (eq? retractor informant)
          (begin
            (set! informant #f)
            (for-each-except retractor
                             inform-about-no-value
                             constraints))
          ; for different retractor, just ignore it
          'ignored))

    (define (connect new-constraint)
      ; add new-constraint into constraints
      (if (not (memq new-constraint constraints))
          (set! constraints
                (cons new-constraint constraints)))

      ; if the connector has value, propagate it!
      (if (has-value? me)
          (inform-about-value new-constraint))
      'done)

    (define (me request)
      (cond ((eq? request 'has-value?)
             (if informant #t #f))
            ((eq? request 'value) value)
            ((eq? request 'set-value!) set-my-value)
            ((eq? request 'forget) forget-my-value)
            ((eq? request 'connect) connect)
            (else
              (error "Unknown operation -- CONNECTOR"
                     request))))
    me))

(define (for-each-except exception procedure c-list)
  ; c-list is constraints list
  (define (loop items)
    (cond ((null? items) 'done)
          ((eq? (car items) exception)
           (loop (cdr items)))
          (else
            (procedure (car items))
            (loop (cdr items)))))

  (loop c-list))

; expose connector interface
(define (has-value? connector)
  (connector 'has-value?))

(define (get-value connector)
  (connector 'value))

(define (set-value! connector new-value informant)
  ((connector 'set-value!) new-value informant))

(define (forget-value! connector retractor)
  ((connector 'forget) retractor))

(define (connect connector new-constraint)
  ((connector 'connect) new-constraint))

;;; Celsius-Fahrenheit-Converter
;;; 9C = 5(F-32)

;       +-------+       +-------+  v  +-------+
; C +---+ m1    |   u   |     m1+-----+a1     |
;       |   *  p+-------+p  *   |     |   +  s+--+ F
;    +--+ m2    |       |     m2+-+ +-+a2     |
;    |  +-------+       +-------+ | | +-------+
;    |                            | |
;   w|                           x| |y
;    |  +---+              +---+  | |    +----+
;    +--+ 9 |              | 5 +--+ +----+ 32 |
;       +---+              +---+         +----+

(define C (make-connector))
(define F (make-connector))

(define (celsius-fahrenheit-converter c f)
  (let ((u (make-connector))
        (v (make-connector))
        (w (make-connector))
        (x (make-connector))
        (y (make-connector)))
    (multiplier c w u)
    (multiplier v x u)
    (adder v y f)
    (constant 9 w)
    (constant 5 x)
    (constant 32 y)
    'ok))

;;; construct the C-F constraint network
(celsius-fahrenheit-converter C F)

(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)
(set-value! C 25 'user)

;;; ==========================
;;; Exercises
;;; ==========================

;; Exercise 3.33
;; averager
;       +--------+      +--------+
; c +---+ m1     |  y   |      a1+--+ a
;       |    *  p+------+s  +    |
;    +--+ m2     |      |      a2+--+ b
;    |  +--------+      +--------+
;    |
;   x|
;    |  +---+
;    +--+ 2 |
;       +---+

(define (averager a b c)
  (let ((x (make-connector))
        (y (make-connector)))
    (adder a b y)
    (multiplier c x y)
    (constant 2 x)
    'ok))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))
(averager a b c)

;; Exercise 3.34
;; if given the value of b, you cannot get the value of a
;; because get the value of a, require a's value too
;; as multiplier constraint followed


;; Exercise 3.35
;; squarer
(define (squarer a b)
  (define (square i) (* i i))
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0 -- SQUARE"
                   (get-value b))
            (set-value! a
                        (sqrt (get-value b))
                        me))
        (if (has-value? a)
            (set-value! b
                        (square (get-value a))
                        me))))

  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me))

  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
            (error "Unknown request -- SQUARER" request))))

  (connect a me)
  (connect b me)
  me)

;; Exercise 3.36
;; ignore, draw env model again


;; Exercise 3.37
;; Simplified C-F Constraint

(define (simplified-C-F-converter x)
  ; F = 9/5 * C + 32
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier y z x)
    z))

(define (cv x)
  (let ((y (make-connector)))
    (constant x y)
    y))

(define C-s (make-connector))
(define F-s (simplified-C-F-converter C-s))

; test:
(set-value! C-s 25 'user)
(get-value F-s) ; get 77
