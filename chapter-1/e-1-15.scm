;;; Bill Xue
;;; 2015-10-02
;;; sin(x)
;;; sin(x) = 3 sin(x/3) - 4 sin^3(x/3)

(define (sine theta)

 (define counter 0) ; count p executes
 (define (cube x) (* x x x))
 (define (p x) (- (* 3 x) (* 4 (cube x))))

 (define (sine-recur alpha)
   (if (not (> (abs alpha) 0.1))
       alpha   ; when |theta| < 0.1, we take sin(theta)=theta
       (begin
          (set! counter (+ counter 1))
          (p (sine-recur (/ alpha 3.0))))))

 (begin
    (print (sine-recur theta))
    (print " p: ")
    (print counter)
    (newline)))

;; the counter is about
;; log_3(a) for sin(a)
