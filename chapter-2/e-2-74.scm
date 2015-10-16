;;; Bill Xue
;;; 2015-10-16
;;; Exercise 2.74
;;; Insatiable Enterprise System

;; a)
;; Every apartment should have interface
(put 'get-record 'apartment-name get-record)

;; b)
;; It should have types:
(put 'get-salary '(apartment-name salary) get-salary)

;; c)
(define (find-employee-record employee-name apartments-records)
  (define (iter employee-name apartments results)
    (if (null? apartments)
        results
        (iter employee-name (cdr apartments)
          (cons ((get 'get-record
                      (quote (apartment-name
                               (car apartments))))
                 employee-name)
                results))))

  (iter employee-name apartments-records '()))

;; d)
;; To add new apartment records,
;; In this system, we just need to install new packages
