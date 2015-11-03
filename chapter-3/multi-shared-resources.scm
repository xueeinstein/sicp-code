;;; Bill Xue
;;; 2015-11-03
;;; Multiple Shared Resources

;;; Exchange two accounts balance
(define (exchange account-1 account-2)
  (let ((difference (- (account-1 'balance)
                       (account-2 'balance))))
    ((account-1 'withdraw) difference)
    ((account-2 'deposit) difference)))

;; if Paul exchange accounts a1 and a2, Peter exchange
;; accounts a2 and a3, and they do it parallelly, obviously,
;; it would cause error if Peter finished during Paul deposits
;; from a2

(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'balance) balance)
            ((eq? m 'serializer)
             ; expose its balance serializer
             balance-serializer)
            (else
              (error "Unknown request -- MAKE-ACCOUNT"
                     m))))
    dispatch))

(define (deposit account amount)
  (let ((s (account 'serializer))
        (d (account 'deposit)))
    ((s d) amount)))

(define (serialized-exchange account-1 account-2)
  (let ((serializer-1 (account-1 'serializer))
        (serializer-2 (account-2 'serializer)))
    ((serializer-1 (serializer-2 exchange))
     account-1
     account-2)))

;; Exercise 3.43
;; 1) Obviously, if exchanges execute sequentially, these
;; three accounts get permutation of 10, 20 and 30
;;
;; 2) Because basic withdraw and deposit operations are
;; serialized, no matter how cross executions that happend,
;; the whole accounts all withdraw and deposit the same
;; differences, in this way the total balances doesn't change!


;; Exercise 3.44
;; Louis is wrong!
;; Because the transfered amount is just a number,
;; it doesn't need to access account balance
;; We only need to keep withdraw and deposit operations
;; serialized.
;;
;; But the differences in exchange is Shared resources,
;; it needs to access both two accounts

;; Exercise 3.45
;; Using Louis's code, in serialized-exchange, we will use
;; the same serializer two times. One in the serialized-exchange
;; and the other in the dispatch function.
;;
;; According to the implementation of the serializer, if a
;; process acquires mutex two times, the busy waiting will
;; never halt.