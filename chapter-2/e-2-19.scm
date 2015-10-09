;;; Bill Xue
;;; 2015-10-09
;;; Count Change with self customized denominations

(define (count-change amount)
  (define (cc a coin-values)
    (cond ((= a 0) 1)    ; amount = 0, only 1 way to change
         ((or (< a 0) (no-more? coin-values)) 0)
         (else (+ (cc a
                     (except-first-denomination coin-values))
                  (cc (- a
                         (first-denomination coin-values))
                     coin-values)))))   ; end of cc

  ; supplementary procedure
  (define (first-denomination coin-values)
    (car coin-values))

  (define (except-first-denomination coin-values)
    (cdr coin-values))

  (define no-more? null?)

  ; main
  (define us-coins (list 50 25 10 5 1))
  (define uk-coins (list 100 50 20 10 5 2 1 0.5))
  (cc amount us-coins))
