;;; Bill Xue
;;; 2015-10-01
;;; define new + and -

(define (plus-recur a b)
 (if (= a 0)
  b
  (inc (plus-recur (dec a) b))))

(define (plus-iter a b)
 (if (= a 0)
  b
  (+ (dec a) (inc b))))

(define (inc x)
 (+ x 1))

(define (dec x)
 (- x 1))

;; Some results:
;; (time (plus-recur 4 5))      ; 896 bytes allocated
;; (time (plus-recur 8 10))     ; 1728 bytes allocated
;;
;; (time (plus-iter 4 5))       ; 192 bytes allocated
;; (time (plus-iter 8 10))      ; 192 bytes allocated
