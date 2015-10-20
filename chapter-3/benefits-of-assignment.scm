;;; Bill Xue
;;; 2015-10-20
;;; Benefits of Assignment
;;;
;;; Assignment and the technology of hiding
;;; state in local variable, we are able to
;;; structure systems in a more modular fashion

;; rand implementation
(define random-init 10)
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))

(define (rand-update x)
  ; generate random integer between 1 and 126
  (let ((a 27) (b 26) (m 127))
    (remainder (+ (* a x) b) m)))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random-real) range))))

;; a modular implementation of estimate-pi
(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))

  (iter trials 0))

;; Result:
;; Quite weird, given larger trials
;; pi converge to 3.113... not 3.14...
;; why?? TODO

;; Exercise 3.5
;; Monte-Carlo Integration
(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (P x y)))

  (let ((rectangle-size
          (* (- x2 x1)
             (- y2 y1))))
    (* rectangle-size
       (monte-carlo trials experiment)
       1.0)))

; test:
; r=1 cycle
(define (size-pi-cycle trials)
  (define (square i)
    (* i i))

  (define (P x y)
    (<= (+ (square (- x 1))
           (square (- y 1)))
        1))

  (estimate-integral P 0 2 0 2 trials))

;; Exercise 3.6
;; New rand
(define rand-me
  (let ((x random-init))
    (lambda (op)
      (cond ((eq? op 'generate)
             (begin
               (set! x (rand-update x))
               x))
            ((eq? op 'reset)
             (lambda (new-x)
               (set! x new-x)))
            (else
             (error "Unknown operation -- RAND-ME"
                    op))))))

; test:
; (rand-me 'generate) 42
; (rand-me 'generate) 17
; (rand-me 'generate) 104
; (rand-me 'generate) 40
;
; ((rand-me 'reset) random-init)
; (rand-me 'generate) 42
; (rand-me 'generate) 17
; (rand-me 'generate) 104
