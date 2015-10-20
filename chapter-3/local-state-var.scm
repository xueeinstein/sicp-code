;;; Bill Xue
;;; 2015-10-19
;;; Local State Variables

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds")))

;; make account
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else
           (error "Unknown request -- MAKE-ACCOUNT"
                  m))))
  dispatch)

;; Exercise 3.1
(define (make-accumulator init-value)
  (lambda (amount)
    (begin
      (set! init-value (+ init-value amount))
      init-value)))

;; Exercise 3.2
(define (make-monitored f)
  (define counter 0)

  (lambda args
    (cond ((and (= (length args) 1)
                (eq? (car args) 'how-many-calls?))
           counter)
          ((and (= (length args) 1)
                (eq? (car args) 'reset-count))
           (set! counter 0))
          (else
            (begin
              (set! counter (+ 1 counter))
              (apply f args))))))

;; Exercise 3.3
(define (make-account-with-pwd balance pwd)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch input-pwd m)
    (if (eq? input-pwd pwd)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else
               (error "Unknown request -- MAKE-ACCOUNT"
                      m)))
        (lambda (amount)
          (begin
            (display "Incorrect password")
            (newline)))))
  dispatch)

;; Exercise 3.4
;; call cops if pwd got wrong over 7 times
(define (make-account-with-pwd-update balance pwd)
  (define tried-allow 7)

  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  ; new operation for Exercise 3.7
  ; share the account operator with joined account
  (define (join op)
    (cond ((eq? op 'withdraw) withdraw)
          ((eq? op 'deposit) deposit)
          (else
           (error "Unknown request -- MAKE-ACCOUNT"
                  op))))

  (define (call-the-cops)
    (lambda (amount)
      (begin
        (display "input password 7 times wrong!")
        (newline)
        (display "calling cops...")
        (newline))))

  (define (dispatch input-pwd m)
    (if (eq? input-pwd pwd)
        (begin
          (set! tried-allow 7)
          (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                ; new operation for Exercise 3.7
                ((eq? m 'join) join)
                (else
                 (error "Unknown request -- MAKE-ACCOUNT"
                        m))))
        (if (> tried-allow 1)
            (lambda (amount)
              (begin
                (set! tried-allow (- tried-allow 1))
                (display "Incorrect password")
                (newline)))
            (call-the-cops))))
  dispatch)