;;; Bill Xue
;;; 2015-11-04
;;; Stream

; Stream is simply a sequence, and stream implementation
; automatically and transparently interleave the construction
; of the stream with its use

;; streams operations
(define the-empty-stream '())

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

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (forced (cdr stream)))

(define (cons-stream a b)
  (cons a (delayed b)))

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

;; suppplementary procedures
(define (delayed p)
  (lambda () p))

(define (delay-v2 p)
  (memo-proc (lambda () p)))

(define (forced delayed-obj)
  (delayed-obj))

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

;; test
(load "../chapter-1/check-prime.scm")
; get the second prime from 10000
(define (test)
  (stream-car (stream-cdr
              (stream-filter
                prime-Fermat-test?
                (stream-enumerate-interval 10000
                                           1000000)))))
