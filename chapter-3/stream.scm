;;; Bill Xue
;;; 2015-11-04
;;; Stream

; Stream is simply a sequence, and stream implementation
; automatically and transparently interleave the construction
; of the stream with its use

;; suppplementary procedures

; delay and memo result
(define (memo-proc proc)
  (let ((already-run? #f)
        (result #f))
    (lambda ()
      (if (not already-run?)
          (begin
            (set! result (proc))
            (set! already-run? #t)
            result)
          result))))

(define-syntax delayed
  (syntax-rules ()
    ((delayed exp)
     (memo-proc (lambda () exp)))))

(define (forced delayed-obj)
  (delayed-obj))

;; streams operations
(define the-empty-stream '())

; cons-stream must be special
; to avoid execute b straightforwardly
; comma operator means eval b firstly
(define-syntax cons-stream
  (syntax-rules (cons)
    ((cons-stream a b)
     (cons a (delayed b)))))

(define (stream-null? stream)
  (null? stream))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s)
                  (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc
                               (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin
        (proc (stream-car s))
        (stream-for-each proc
                         (stream-cdr s)))))

(define (display-stream s)
  (define (display-line x)
    (newline)
    (display x))

  (stream-for-each display-line s))

(define (stream-head s n)
  (define (iter s i)
    (if (< i n)
        (begin
          (display (stream-car s))
          (display " ")
          (iter (stream-cdr s) (+ i 1)))))

  (display "( ")
  (iter s 0)
  (display ")")
  (newline))

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (forced (cdr stream)))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low
                   (stream-enumerate-interval (+ low 1)
                                              high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream)
         the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else
          (stream-filter pred
                         (stream-cdr stream)))))

;; test
(load "../chapter-1/check-prime.scm")
; get the second prime from 10000
(define (test)
  (stream-car (stream-cdr
              (stream-filter
                prime-Fermat-test?
                (stream-enumerate-interval 10000
                                           1000000)))))

;; Exercise 3.50
;; stream-map extension
;; where proc has multiple args
(define (stream-map-ext proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
        (apply proc (map stream-car argstreams))
        (apply stream-map-ext
               (cons proc (map stream-cdr argstreams))))))

(define (stream-map-ext-test)
  (define proc
    (lambda (a b) (+ a b)))

  (define stream-1 (stream-enumerate-interval 1 10))
  (define stream-2 (stream-enumerate-interval 11 20))

  (display-stream
    (stream-map-ext proc stream-1 stream-2)))

;; Exercise 3.51
(define (show x)
  (define (display-line x)
    (newline)
    (display x))

  (display-line x)
  x)

;; test
(define x (stream-map show
                      (stream-enumerate-interval 0 10)))
; output:
; 0

(stream-ref x 5)
; output:
; 1
; 2
; 3
; 4
; 55
(stream-ref x 7)
; output:
; 6
; 77

;; Exercise 3.52
(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20)))
; here, sum = 1

(define y (stream-filter even? seq))
; here, sum = 6, because 6 is the first even num in seq

(define z (stream-filter (lambda (x)
                           (= (remainder x 5) 0))
                         seq))
; here, sum = 10

(stream-ref y 7)
; here, sum = 136

(display-stream z)
; here, sum = 210
