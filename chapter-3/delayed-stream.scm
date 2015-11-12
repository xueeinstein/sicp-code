;;; Bill Xue
;;; 2015-11-12
;;; Stream and Delayed Evaluation

(load "inf-stream.scm")
;; solve the differential equation
;; dy/dt = f(y)

;                          | y0
;                          |
;    +---------+      +----v-----+
;    |         |  dy  |          |   y
; +--> map: f  +------> integral +--+->
; |  |         |      |          |  |
; |  +---------+      +----------+  |
; |                                 |
; +---------------------------------+

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (forced delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))

  int)

(define (solve f y0 dt)
  ; when try to get y, dy is unavailable
  ; so we delay dy firstly!
  (define y (integral (delayed dy) y0 dt))
  (define dy (stream-map f y))
  y)

;; Exercise 3.77
(define (integral-v2 delayed-integrand initial-value dt)
  (cons-stream initial-value
               (let ((integrand (forced delayed-integrand)))
                 (if (stream-null? integrand)
                     the-empty-stream
                     (integral-v2 (delayed (stream-cdr integrand))
                                  (+ (* dt (stream-car integrand))
                                     initial-value)
                                  dt)))))

(define (solve-v2 f y0 dt)
  (define y (integral-v2 (delayed dy) y0 dt))
  (define dy (stream-map f y))
  y)

;; Exercise 3.78
;; solve second order linear differential equation
;; d2y/dt2 - a dy/dt - by = 0

(define (solve-2nd a b dt y0 dy0)
  (define y (integral (delayed dy) y0 dt))
  (define dy (integral (delayed ddy) dy0 dt))
  (define ddy (add-streams (scale-stream dy a)
                           (scale-stream y b)))
  y)

;; Exercise 3.79
;; solve second order linear differential equation
;; d2y/dt2 = f(dy/dt, y)
(define (solve-2nd-f f dt y0 dy0)
  (define y (integral (delayed dy) y0 dt))
  (define dy (integral (delayed ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)

;; Exercise 3.80
;; RLC circuit
(define (RLC r l c dt)
  (define (Vc Vc0 Il0)
    (integral (delayed (dVc Vc0 Il0)) Vc0 dt))

  (define (dVc Vc0 Il0)
    (scale-stream (Il Vc0 Il0)
                  (/ -1 c)))

  (define (Il Vc0 Il0)
    (integral (delayed (dIl Vc0 Il0)) Il0 dt))

  (define (dIl Vc0 Il0)
    (add-streams (scale-stream (Vc Vc0 Il0)
                               (/ 1 l))
                 (scale-stream (Il Vc0 Il0)
                               (/ r l -1))))

  (define (Vc-Il-stream Vc0 Il0)
    (stream-map-ext (lambda (i j) (cons i j))
                    (Vc Vc0 Il0)
                    (Il Vc0 Il0)))

  Vc-Il-stream)

(define RLC-test-circuit
  ((RLC 1 1 0.2 0.1) 10 0))
