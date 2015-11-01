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