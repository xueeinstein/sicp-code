;;; Bill Xue
;;; 2015-10-04
;;; Small optimization for smallest-divisor


(define (prime-by-divisor? n)
  ; find smallest divisor
  (define (smallest-divisor)
    (find-divisor 2))

  (define (find-divisor test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor (next test-divisor)))))

  ; optimization for test-divisor
  ; if 2 is divides? true, then all even number
  ; should be ignored
  (define (next x)
    (if (= x 2)
        3
        (+ x 2)))

  ; supplementary function
  (define (square x)
    (* x x))

  (define (divides? a b)
    (= (remainder b a) 0))

  ; main
  (= n (smallest-divisor)))

;; =============================
;; copy from e-1-22.scm

(define (runtime)
  "current time in nanoseconds"
  (* (time->seconds (current-time))
     1000000))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime-by-divisor? n)
      (report-prime (- (runtime) start-time))
      (begin
            (display " isn't a prime.")
            (report-prime (- (runtime) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  (display " ns")
  (newline))

;; Search for Prime
;; find the minimum prime which is larger then n

(define (search-for-primes n)
  (do ((is-found #f)
       (start-time 0)
       (current-num n))
      (is-found (- current-num 1))  ; found the minimum one
      (begin
          (display current-num)
          (set! start-time (runtime))
          (if (prime-by-divisor? current-num)
              (set! is-found #t)
              (display " isn't a prime."))
          ; report time
          (report-prime (- (runtime) start-time))
          (set! current-num (+ current-num 1)))))

;; Results:
;; n = 1000, 55ns
;; n = 10000, 166ns
;; n = 100000, 516ns
;; n = 1000000, 2071ns
;;
;; almost 2/3 of original cost
