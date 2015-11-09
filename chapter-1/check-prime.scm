;;; Bill Xue
;;; 2015-10-04
;;; Check prime

;; Method I: find smallest divisor between 1 and sqrt(N)
;; O(sqrt(N))

(define (prime-by-divisor? n)
  ; find smallest divisor
  (define (smallest-divisor)
    (find-divisor 2))

  (define (find-divisor test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor (+ test-divisor 1)))))

  ; supplementary function
  (define (square x)
    (* x x))

  (define (divides? a b)
    (= (remainder b a) 0))

  ; main
  (= n (smallest-divisor)))

;; Method II: Fermat's little theorem (Fermat test)
;; O(logN)
;; Attention: some special numbers, i.e. Carmichael number
;; can pass Fermat test, but they are not prime

(define (prime-Fermat-test? n)
  ; compute base^exp % m
  ; xy % m = ( (x % m) * (y % m) ) % m
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           ; a^b % m = (a^(b/2) % m)^2 % m
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
           ; a^b % m = (a * (a^(b-1) % m) ) % m
           (remainder (* base (expmod base (- exp 1) m))
                      m))))

  ; Fermat test
  ; get a random number between 1 and n-1
  ; check (expmod a n n) = a or not
  (define (fermat-test)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

  ; fast prime checker
  (define (fast-prime? times)
    (cond ((= times 0) #t)
          ((fermat-test) (fast-prime? (- times 1)))
          (else #f)))

  ; supplementary functions
  (define (square x)
    (* x x))

  ; main
  ; default check times is 10
  (fast-prime? 10))

;; Method III: Miller-Rabin Test
;; Attention: No Carmichael number error
;; exercise 1.28

(define (prime-Miller-Rabin-test? n)
  ; compute base^exp % m
  ; updated with un-normal square-root check
  ; xy % m = ( (x % m) * (y % m) ) % m
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (let ((square-root (expmod base (/ exp 2) m)))
                (if (is-normal-square-root? square-root m)
                    0     ; 0 represents fail signal
                    (remainder (square square-root) m))))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))

  (define (is-normal-square-root? x n)
    (and (not (= x 1))       ; x != 1
         (not (= x (- n 1))) ; x != n-1
         (= (remainder (square x) n) 1)))   ; x^2 % n = 1

  ; Miller-Rabin test
  ; get a random number between 1 and n-1
  ; check expmod(a (n-1) n) = 1 or not
  (define (Miller-Rabin-test)
    (define (try-it a)
      (= (expmod a (- n 1) n) 1))
    (try-it (+ 1 (random (- n 1)))))

  ; fast prime checker
  (define (fast-prime? times)
    (cond ((= times 0) #t)
          ((Miller-Rabin-test) (fast-prime? (- times 1)))
          (else #f)))

  ; supplementary functions
  (define (square x)
    (* x x))

  ; main
  ; default check times is 10
  (fast-prime? 10))
