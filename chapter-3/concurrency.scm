;;; Bill Xue
;;; 2015-10-29
;;; Concurrency

;; Exercise 3.38
;; a)
;; 1. suppose the bank execute these three transaction
;; in order: Peter -> Paul -> Mary
;; the balance value is: (100 + 10 - 20) / 2 = 45
;; 2. in order: Peter -> Mary -> Paul
;; the balance value is: (100 + 10) / 2 - 20 = 35
;; 3. in order: Paul -> Peter -> Mary
;; the balance value is: (100 - 20 + 10) / 2 = 45
;; 4. in order: Paul -> Mary -> Peter
;; the balance value is: (100 - 20) / 2 + 10 = 50
;; 5. in order: Mary -> Peter -> Paul
;; the balance value is: 100 / 2 + 10 - 20 = 40
;; 6. in order: Mary -> Paul -> Peter
;; the balance value is: 100 / 2 - 20 + 10 = 40
;;
;; so the possible balance value is: 35, 40, 45, 50
;;
;; b)
;; Every withdraw operation can be divided into three
;; small steps:
;; access balance(A), get new balance(G), set balance(S)
;;
;; if the bank allow cross transaction, the final balance
;; depends on A & S operation order of Peter, Paul and Mary
;;
;; Notably, there three types:
;; Type I: (three cross)all A opers finished before S opers. e.g.
;; A1  S1
;; A2     S2
;; A3       S3
;; the final balance depends on the final S oper, so it can be
;; 100+10=110, 100-20=80, or 100/2=50
;;
;; Type II: no actual cross transaction. e.g.
;; A1 S1
;;       A2 S2
;;             A3 S3
;; this is a) question, the final balance can be 35, 40, 45, 50
;;
;; Type III: (two cross) e.g.
;; A1 S1
;;       A2 S2
;;       A3    S3
;; the final balance can be
;; 110-20=90, 110/2=55, 80+10=90, 80/2=40, 50+10=60, 50-20=30
;;
;; Summary:
;; possible final balance is:
;; 110, 90, 80, 60, 55, 50, 45, 40, 35, 30
;;


;; Exercise 3.39
(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x
                                   ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))

;; two procedure in serializer, p1: x+1->x, p2: x*x
;; 1. p1 execute before p2
;; final procedure is (set! x 121), so final x is 121
;; 2. p2 execute before p1
;; after p2, it generates new procedure, p3: (set! x 100)
;; if p3 execute before p1, get final x is 101
;; if p1 execute before p3, get final x is 100
;;
;; Summary:
;; All possible x value is: 100, 101, 121

;; Exercise 3.40
(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

;; two parallel procedures,
;; p1: (set! x (* x x)), p2: (set! x (* x x x))
;; and p1 has two A(access) opers, p2 has three A opers
;; while p1 two A opers may get different x value due to
;; S(set) oper from p2, and vice versa.
;; So x value can be:
;; Type I: no cross opers
;; (10^3)^2=10^6, (10^2)^3=10^6, 100, 1000
;; Type II: p2 S oper cross p1 A opers
;; 10*(10^3)=10^4
;; Type III: p1 S oper cross p2 A opers
;; 10*100*100=10^5 or 10*10*100=10^4

(define x 10)
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x))))
                  (s (lambda () (set! x (* x x x)))))
;; after serializing, only 10^6 exists


;; Exercise 3.41
;;
;; Parallel access oper cannot influence the x value,
;; Ben is wrong, otherwise serialized withdraw and depends
;; opers will get different results

;; Exercise 3.42
(define (make-account-vBen balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (let ((protected (make-serializer)))
    (let ((protected-withdraw (protected withdraw))
          (protected-deposit (protected deposit)))
      (define (dispatch m)
        (cond ((eq? m 'withdraw) protected-withdraw)
              ((eq? m 'deposit) protected-deposit)
              ((eq? m 'balance) balance)
              (else
                (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
      dispatch)))
;; it's safe!
;; Assuming we make account, try to withdraw 10, 20 at the same
;; time. If using Ben's implementation, we are parallel executing
;; (protected-withdraw 10) and (protected-withdraw 20)
;; The only difference is the new one serialize the procedures
;; before call the functions, but the original one do it when
;; call withdraw or deposit.