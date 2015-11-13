;;; Bill Xue
;;; 2015-11-12
;;; Modularity of Functional Programs and Modularity of Objects

(load "inf-stream.scm")
(define random-init 10)

(define (rand-update x)
  ; generate random integer between 1 and 256
  (let ((a 27) (b 26) (m 257))
    (remainder (+ (* a x) b) m)))

(define random-numbers
  (cons-stream random-init
               (stream-map rand-update random-numbers)))

; Cesàro's theorem:
; The probability of two randomly selected integers being
; coprime is 6/(pi^2)
(define (map-successive-pairs f s)
  (cons-stream
    (f (stream-car s) (stream-ref s 1))
    (map-successive-pairs f
                          (stream-cdr (stream-cdr s)))))

(define cesaro-stream
  (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1))
                        random-numbers))

; Monte-Carlo Method stream version
(define (monte-carlo-stream experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream (/ passed (+ passed failed))
                 (monte-carlo-stream
                   (stream-cdr experiment-stream)
                   passed
                   failed)))

  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define pi
  (stream-map (lambda (p)
                (if (= p 0) 0 (sqrt (/ 6.0 p))))
              (monte-carlo-stream cesaro-stream 0 0)))

;; Exercise 3.81
(define (random-numbers-gr op-stream)
  (define random-numbers
    (cons-stream
      random-init
      (stream-map-ext (lambda (num op)
                        (cond ((eq? op 'generate)
                               (rand-update num))
                              ((and (pair? op)
                                    (eq? (car op) 'reset))
                               ; reset to new value
                               (cdr op))
                              (else
                               (error "Bad operation -- "
                                      op))))
                      random-numbers
                      op-stream)))

  random-numbers)
; test:
(define op-stream
  (cons-stream 'generate
               (cons-stream 'generate
                            (cons-stream (cons 'reset 1)
                                         op-stream))))

(define xy1-stream
  (random-numbers-gr op-stream))

;; Exercise 3.82
;; Monte-Carlo Integration stream version
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random 1.0) range))))

(define (estimate-integral-stream P x1 x2 y1 y2)
  (define (experiment)
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (P x y)))

  (define experiment-stream
    (stream-map (lambda (i) (experiment))
                ones))

  (let ((rectangle-size
          (* (- x2 x1) (- y2 y1))))
    (scale-stream
      (monte-carlo-stream experiment-stream 0 0)
      rectangle-size)))

; test:
; y = x^2 integral from 0 to 1
(define x2-integral-stream
  (estimate-integral-stream (lambda (x y) (< y (* x x)))
                            0 1 0 1))

; (stream-ref x2-integral-stream 1000) ; very close to 1/3
