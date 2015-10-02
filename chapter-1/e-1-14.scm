;;; Bill Xue
;;; 2015-10-02
;;; count change with trace
;;; TODO, how to visualize the map recursive procedure
;;; into a tree?

(define (count-change amount)
  (define (cc a kinds-of-coins)
   ;; trace
   (begin
        (print "(cc ")
        (print a)
        (print " ")
        (print kinds-of-coins)
        (print ")")
        (newline))
   (cond ((= a 0) 1)    ; amount = 0, only 1 way to change
        ((or (< a 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc a
                    (- kinds-of-coins 1))
                 (cc (- a
                        (first-denomination kinds-of-coins))
                    kinds-of-coins)))))   ; end of cc

  (define (first-denomination kinds-of-coins)
   (cond ((= kinds-of-coins 1) 1)   ; 1 cent
         ((= kinds-of-coins 2) 5)   ; 5 cent
         ((= kinds-of-coins 3) 10)  ; 10 cent
         ((= kinds-of-coins 4) 25)  ; quarter dollar
         ((= kinds-of-coins 5) 50)  ; half dollar
   ))   ; end of first-denomination

  (cc amount 5))

(time (count-change 11))
