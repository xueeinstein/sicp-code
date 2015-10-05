;;; Bill Xue
;;; 2015-10-05
;;; Procedure as Parameter

;; Procedure I
;; a + (a+1) +... + b
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

;; Procedure II
;; a^3 + (a+1)^3 +...+ b^3
(define (sum-cubes a b)
  (define (cube x)
    (* x x x))

  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

;; Procedure III
;; 1/(1*3) + 1/(5*7) + ...
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2)))
         (pi-sum (+ a 4) b))))

;; We can summary above three procedure
;; In fellow pattern
;; Just like: sum = f(a) +...+ f(b)
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

;; Then we can define sum-cubes as:
(define (sum-cubes-new a b)
  ; supplementary functions
  (define (cube x)
    (* x x x))

  (define (inc x)
    (+ x 1))

  ; main
  ; implement from abstract function
  (sum cube a inc b))

;; Then we can define sum-integers as:
(define (sum-integers-new a b)
  ; supplementary functions
  (define (identity x) x)

  (define (inc x)
    (+ x 1))

  ; main
  ; implement from abstract function
  (sum identity a inc b));

;; Then we can define pi-sum as:
(define (pi-sum-new a b)
  ; supplementary functions
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))

  ; main
  ; implement from abstract function
  (sum pi-term a pi-next b))
