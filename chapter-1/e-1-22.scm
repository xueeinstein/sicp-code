;;; Bill Xue
;;; 2015-10-04
;;; Search Prime in specified range

(load "check-prime.scm")

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
;; (search-for-primes 1000)
;; 1009 *** 70. ns
;;
;; (search-for-primes 10000)
;; 10007 *** 196. ns
;;
;; (search-for-primes 100000)
;; 100003 *** 835. ns
;;
;; (search-for-primes 1000000)
;; 1000003 *** 3092. ns
;;
;; sqrt(10) = 3.16
;; 196 / 70 = 2.8
;; 835 / 196 = 4.26
;; 3092 / 835 = 3.70
