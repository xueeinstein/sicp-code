;;; Bill Xue
;;; 2015-11-09
;;; Infinity Stream

(load "stream.scm")

;; infinity integers generator
(define (integers-starting-from n)
  (cons-stream n
               (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (divisible? x y)
  (= (remainder x y) 0))

(define no-sevens
  (stream-filter (lambda (x)
                   (not (divisible? x 7)))
                 integers))

;; infinity Fibonacci sequence generator
(define (fibgen a b)
  (cons-stream a
               (fibgen b (+ a b))))

; every fast fibs
; because it uses memorization tech in stream
(define fibs
  (fibgen 0 1))

;; sieve of Eratosthenes
;; get the primes
(define (sieve stream)
  (cons-stream
    (stream-car stream)
    (sieve (stream-filter ; filter out n*prime nums
             (lambda (x)
               (not (divisible? x
                                (stream-car stream))))
             (stream-cdr stream)))))

(define primes
  (sieve (integers-starting-from 2)))

;; defining stream implicitly
(define ones
  (cons-stream 1 ones))

(define (add-streams s1 s2)
  (stream-map-ext + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x)
                (* x factor))
              stream))

; re-define integers, fibs and primes
(define integers-v2
  (cons-stream 1
               (add-streams ones integers-v2)))

(define fibs-v2
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs-v2)
                                         fibs-v2))))

(define primes-v2
  (cons-stream
    2
    (stream-filter prime-v2?
                   (integers-starting-from 3))))

(define (prime-v2? n)
  (define (square i) (* i i))

  ; actually, it's also sieve of Eratosthenes
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) #t)
          ((divisible? n (stream-car ps)) #f)
          (else (iter (stream-cdr ps)))))

  (iter primes-v2))

(define power2
  ; get stream of 1 2 4 8 16...
  (cons-stream 1
               (scale-stream power2 2)))

;; Exercise 3.53
;; (define s (cons-stream 1 (add-streams s s)))
;; s: (1 2 4 8...)
;; s is power2!

;; Exercise 3.54
(define (mul-streams s1 s2)
  (stream-map-ext * s1 s2))

; the nth element is (n+1)!
(define factorials
  (cons-stream 1
               (mul-streams (integers-starting-from 2)
                            factorials)))

;; Exercise 3.55
(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (scale-stream ones
                                          (stream-car s))
                            (partial-sums (stream-cdr s)))))

; test:
; (partial-sums integers) ; get stream 1, 3, 6, 10, 15,...

;; Exercise 3.56
;; R.Hamming Problem
(define (merge-streams s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car
                               (merge-streams (stream-cdr s1)
                                              s2)))
                 ((> s1car s2car)
                  (cons-stream s2car
                               (merge-streams s1
                                              (stream-cdr s2))))
                 (else
                  (cons-stream
                    s1car
                    (merge-streams (stream-cdr s1)
                                   (stream-cdr s2)))))))))

; S is stream 1, 2, 3, 4, 5, 6, 8, 9, 10, 12 ...
; all elements is 2^a*3^b*5^c combination
(define S
  (cons-stream 1
               (merge-streams
                 (scale-stream S 2)
                 (merge-streams (scale-stream S 3)
                                (scale-stream S 5)))))

;; Exercise 3.57
;; Too simple! If we don't use memo-proc in delay implementation
;; when we compute fibs-v2, we would compute the same fib(n)
;; multiple times. Specifically, it works as tree recurse to
;; get Fibonacci sequence. So it's exponential growth.

;; Exercise 3.58
;; expand the fraction num/den to decimals representation
(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den)
            den
            radix)))

; (expand 3 8 10) ; get (3 7 5 0 0 ...)

;; Exercise 3.59
;; power series
; a)
(define (integrate-series arg-stream)
  (stream-map-ext (lambda (i a)
                    (* (/ 1 i) a))
                  integers
                  arg-stream))

; b)

; e^x = 1 + x + x^2/2 + x^3/(3*2) + ...
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

; cos(x) = 1 - x^2/2 + x^4/(4*3*2) - ...
(define cosine-series
  (cons-stream 1
               (scale-stream
                 (integrate-series sine-series)
                 -1)))

; sin(x) = x - x^3/(3*2) + x^5/(5*4*3*2) - ...
(define sine-series
  (cons-stream 0
               (integrate-series cosine-series)))

;; Exercise 3.60
; a * b = (a0 a')*(b0 b') = (cons a0*b0 (a0*b' + a'*b))
(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1)
                  (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2)
                                          (stream-car s1))
                            (mul-series (stream-cdr s1)
                                        s2))))

(define (mul-series-test)
  (add-streams (mul-series cosine-series cosine-series)
               (mul-series sine-series sine-series)))

; (mul-series-test) get stream (1 0 0 ...), which means
; cos(1)^2 + sin(1)^2 = 1
; and the sine-series, cosine-series are right with this case

;; Exercise 3.61
;; get power series of 1/S from ps of S
(define (reciprocal-series s)
  (cons-stream 1
               (scale-stream (mul-series (stream-cdr s)
                                         (reciprocal-series s))
                             -1)))

;; Exercise 3.62
;; div-series
(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
      (error "Try to divide zero series -- DIV-SERIES"
             (stream-car s2))
      (mul-series s1
                  (reciprocal-series s2))))

; test:
(define (power-series-val s x)
  (define precision 20)
  (define i 0)
  (define sum 0)

  ; a*x^i
  (define (val a)
    (* a (expt x i)))

  (define (iter s)
    (if (> i precision)
        sum ; return sum
        (begin
          (set! sum
                (+ sum (val (stream-car s))))
          (set! i (+ i 1))
          (iter (stream-cdr s)))))

  (iter s))

(define tan-series
  (div-series sine-series cosine-series))

(define pi 3.1415926)
(power-series-val sine-series pi) ; get 0
(power-series-val cosine-series pi) ; get -1
(power-series-val tan-series (/ pi 4)) ; get 1
