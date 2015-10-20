;;; Bill Xue
;;; 2015-10-20
;;; Pitfalls of Assignment
;;;
;;; Assignment changes program into imperative programming
;;; style, make it hard to clearify sameness and change,
;;; drive you pay attention to assignment flow, worse for
;;; parallel computing

;; Exercise 3.7

; load make-account
(load "local-state-var.scm")
(define (make-join shared-account origin-pwd pwd)
  (define (dispatch shared-operator)
    (lambda (input-pwd m)
      (if (eq? input-pwd pwd)
          (shared-operator m)
          (lambda (amount)
            (begin
              (display "Incorrect password")
              (newline))))))

  ; This implementation, it's one-time origin-pwd verification!
  ; so if origin-pwd changed, this join account can
  ; also operate on the shared-account
  (dispatch
    (shared-account origin-pwd 'join)))

;; test:
;; (define jack (make-account-with-pwd-update 100 '123))
;; (define peter (make-join jack '123 '234))
;; ((jack '123 'withdraw) 0)
;; 100
;; ((peter '234 'withdraw) 10)
;; 90
;; ((jack '123 'withdraw) 0)
;; 90


;; Exercise 3.8
(define f
  (lambda (first-value)
    (set! f (lambda (second-value) 0))
    first-value))

; test:
; (+ (f 0) (f 1)) ; first run after load f
; 0 ; gambit execute from left to right!
