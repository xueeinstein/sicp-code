;;; Bill Xue
;;; 2015-11-10
;;; Stream Paradigm

(load "inf-stream.scm")

;; formulate iterations as stream processes
(define (sqrt-stream x)
  (define (average a b)
    (/ (+ a b) 2))

  (define (sqrt-improve guess x)
    (average guess (/ x guess)))

  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))

  guesses)

(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (scale-stream (pi-summands (+ n 2))
                             -1)))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1))
                4))

;; sequence accelerator
;; Leonhard Euler accelerator
(define (euler-transform s)
  (define (square i) (* i i))

  (let ((s0 (stream-ref s 0))   ; S_{n-1}
        (s1 (stream-ref s 1))   ; S_n
        (s2 (stream-ref s 2)))  ; S_{n+1}
    (cons-stream (- s2
                    (/ (square (- s2 s1))
                       (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

;; tableau
(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

; super accelerator of pi-stream
(define super-pi-stream
  (accelerated-sequence euler-transform pi-stream))

;; Exercise 3.63
;; The function defined by Louis calls `(sqrt-stream x)`
;; recursively, which yields a new sequence with the same
;; values, only not memotized yet. Thus this version is
;; slower, but if memoization didn't take place, both
;; implementations would be the same.


;; Exercise 3.64
;; stream-limit
(define (stream-limit stream tolerance)
  (if (< (abs (- (stream-ref stream 1)
                 (stream-ref stream 0)))
         tolerance)
    (stream-ref stream 1)
    (stream-limit (stream-cdr stream)
                  tolerance)))

(define (sqrt-me x tolerance)
  (stream-limit (sqrt-stream x)
                tolerance))

;; Exercise 3.65
;; ln2 = 1 - 1/2 + 1/3 - 1/4 + ...
(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (scale-stream (ln2-summands (+ n 1))
                             -1)))

(define ln2-stream
  (partial-sums (ln2-summands 1)))

(define ln2-stream-a1
  (euler-transform ln2-stream))

(define ln2-stream-a2
  (euler-transform ln2-stream-a1))
; ln2-stream converge faster from a1 to a2

;; infinite streams of pairs
(define (interleave-streams s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave-streams s2
                                       (stream-cdr s1)))))
; get matrix of S and T
; (S0 T0) (S0 T1) (S0 T2) ...
;         (S1 T1) (S1 T2) ...
;                 (S2 T2) ...
(define (pairs-streams s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave-streams
      (stream-map (lambda (x)
                    (list (stream-car s) x))
                  (stream-cdr t))
      (pairs-streams (stream-cdr s)
                     (stream-cdr t)))))

;; Exercise 3.66
(define int-pairs
  (pairs-streams integers integers))

; We notice that the part II: (S0 T1) (S0 T2) ...
; interleave with the part III: (the down-triangle part)
; it means that (1 i) format pairs alternating appear in the
; int-pairs, only (1 1) and (1 2) appear together
;
; so the id of (1 n), where n>2 is:
; 1 + 2*(n - 2) + 1 = 2*n - 2
; (1 100) is at the 198th position

; for (i i) format pairs, through tracing the inf-stream
; in the matrix, we notice that:
; P(i+1 i+1) = P(i i) * 2 + 1 and P(1 1) = 1
; so P(i i) = 2^(i-1) + sum(1+ 2 + 2^2 + ... + 2^(i-2)) =
; 2^i - 1, where i > 1
; so (100 100) is at the (2^100-1) th position

;; Exercise 3.67
; get matrix of S and T
; (S0 T0) (S0 T1) (S0 T2) ...
; (S1 T0) (S1 T1) (S1 T2) ...
; (S2 T0) (S2 T1) (S2 T2) ...

(define (full-pairs-streams s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (join-three-streams
      (stream-map (lambda (x)
                    (list (stream-car s) x))
                  (stream-cdr t))
      (stream-map (lambda (x)
                    (list x (stream-car t)))
                  (stream-cdr s))
      (full-pairs-streams (stream-cdr s)
                          (stream-cdr t)))))

(define (join-three-streams s1 s2 s3)
  (if (stream-null? s1)
      (interleave-streams s2 s3)
      (cons-stream (stream-car s1)
                   (join-three-streams s2
                                       s3
                                       (stream-cdr s1)))))

(define full-int-pairs
  (full-pairs-streams integers integers))

;; Exercise 3.68
;; If we use Louis's pairs, this will not generate stream
;; because there is no delay in pairs.
;; Louis's pairs will try to get stream-cdr recursively.
;; But with infinity stream, Louis's pairs will run in
;; infinite loop

;; Exercise 3.69
;; si <= ti <= ui
(define (triples-streams s t u)
  (cons-stream
    (list (stream-car s)
          (stream-car t)
          (stream-car u))
    (interleave-streams
      (stream-map (lambda (x)
                    (cons (stream-car s) x))
                  (stream-cdr (pairs-streams t u)))
      (triples-streams (stream-cdr s)
                       (stream-cdr t)
                       (stream-cdr u)))))

(define (get-phythagorean-nums)
  (define (square i) (* i i))
  (define triples
    (triples-streams integers integers integers))
  (stream-filter (lambda (x)
                   (= (+ (square (car x))
                         (square (cadr x)))
                      (square (caddr x))))
                 triples))

(define phythagorean-numbers
  (get-phythagorean-nums))

;; Exercise 3.70
(define (merge-weighted-pairs s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (let ((s1car-weight (apply weight s1car))
                 (s2car-weight (apply weight s2car)))
             (cond ((< s1car-weight s2car-weight)
                    (cons-stream s1car
                                 (merge-weighted-pairs
                                   (stream-cdr s1)
                                   s2
                                   weight)))
                   ((> s1car-weight s2car-weight)
                    (cons-stream s2car
                                 (merge-weighted-pairs
                                   s1
                                   (stream-cdr s2)
                                   weight)))
                   (else
                    (cons-stream
                      s1car
                      ; record the same weight pair
                      (cons-stream s2car
                                   (merge-weighted-pairs
                                     (stream-cdr s1)
                                     (stream-cdr s2)
                                     weight))))))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted-pairs
      (stream-map (lambda (x)
                    (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s)
                      (stream-cdr t)
                      weight)
      weight)))

; a)
(define weighted-int-pairs-a
  (weighted-pairs integers integers (lambda (i j)
                                      (+ i j))))

; b)
(define b-ints
  (stream-filter (lambda (x)
                   (or (divisible? x 2)
                       (divisible? x 3)
                       (divisible? x 5)))
                 integers))

(define weighted-int-pairs-b
  (weighted-pairs b-ints b-ints (lambda (i j)
                                  (+ (* 2 i)
                                     (* 3 j)
                                     (* 5 i j)))))

;; Exercise 3.71
;; Ramanujan numbers
(define (get-ramanujan-numbers)
  (define (cube i) (* i i i))
  (define (weight i j)
    (+ (cube i) (cube j)))
  (define stream
    (stream-map (lambda (pair) (apply weight pair))
                (weighted-pairs integers integers weight)))

  (define (special-filter s)
    (cond ((stream-null? s)
           the-empty-stream)
          ((= (stream-ref s 0)
              (stream-ref s 1))
           (cons-stream (stream-car s)
                        (special-filter
                          (stream-cdr (stream-cdr s)))))
          (else
           (special-filter (stream-cdr s)))))

  (special-filter stream))

(define ramanujan-numbers
  (get-ramanujan-numbers))

;; Exercise 3.72
(define (have-three-same-square-sum)
  (define (square i) (* i i))
  (define (weight i j)
    (+ (square i) (square j)))
  (define stream
    (weighted-pairs integers integers weight))

  (define (special-filter s)
    (cond ((stream-null? s)
           the-empty-stream)
          ((= (apply weight (stream-ref s 0))
              (apply weight (stream-ref s 1))
              (apply weight (stream-ref s 2)))
           ; here, record pairs
           (cons-stream
             (list (apply weight (stream-car s))
                   (stream-ref s 0)
                   (stream-ref s 1)
                   (stream-ref s 2))
            (special-filter (stream-cdr
                            (stream-cdr (stream-cdr s))))))
          (else
           (special-filter (stream-cdr s)))))

  (special-filter stream))

(define e72-stream
  (have-three-same-square-sum))
