;;; Bill Xue
;;; 2015-10-10
;;; Nested Mappings

;; load signal-flow structure
(load "conventional-interfaces.scm")

;; Nested Map
(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

;; Example I
;; 1 <= j < i <= n, find (i, j i+j) which i+j is prime

(load "../chapter-1/check-prime.scm") ; load prime-by-divisor?
(define (prime-sum-pairs n)
  ; generate all (i, j) pair
  (let ((ij-pairs
          (accumulate
            append
            '()
            (map (lambda (i)
                    (map (lambda (j)
                            (list i j))
                         (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 n)))))
      ; filter i+j prime
      (accumulate
        ; for nil, op is y
        (lambda (x y)
          (if (null? x)
              y
              (cons x y)))
        '()
        (map (lambda (ij)
                (let ((i (car ij))
                      (j (cadr ij)))
                     (if (prime-by-divisor? (+ i j))
                         (list i j (+ i j))
                         '())))
             ij-pairs))))

;; Implementation on book
;; generage (i, j) pairs -> filter i+j prime -> make pair sum
(define (prime-sum-pairs-onbook n)
  (define (prime-sum? pair)
    (prime-by-divisor? (+ (car pair) (cadr pair))))

  (define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

  ; main
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                  (lambda (i)
                    (map (lambda (j) (list i j))
                         (enumerate-interval 1 (- i 1))))
                  (enumerate-interval 1 n)))))

;; Example II
;; Permutations
(define (permutations s)
  (define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
            sequence))

  (if (null? s)
      (list '())
      (flatmap (lambda (x)
                  (map (lambda (p) (cons x p))
                       (permutations (remove x s))))
               s)))


;; ===========================
;; Exercises
;; ===========================


;; Exercise 2.40
(define (unique-pairs n)
  (flatmap (lambda (i)
              (map (lambda (j) (list i j))
                   (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

;; Exercise 2.41
;; 1 <= k < j < i <=n and i+j+k=s
(define (sum-three-s n s)
  (filter
    (lambda (ijk)
      (= (+ (car ijk) (cadr ijk) (list-ref ijk 2)) s))
    ; generate (i j k) pairs
    ; strategy, generate (i j) firstly, then add k
    (accumulate
      (lambda (ij y)
        (append (map (lambda (k)
                        (list (car ij) (cadr ij) k))
                     (enumerate-interval 1 (- (cadr ij) 1)))
                y))
      '()
      (unique-pairs n))))

;; Exercise 2.42
;; Eight queens chess problem
;; TODO: filter out results, rotation and reflection equations
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list '())
        (filter
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              ; rest-of-queens is one way to put
              ; k-1 queens
              (map (lambda (new-row)
                      (adjoin-position
                        new-row k rest-of-queens))
                   (enumerate-interval 1 board-size)))
            ; k-1 queens are ready
            (queen-cols (- k 1))))))

  (define (adjoin-position new-row k rest-of-queens)
    (append rest-of-queens (list new-row)))

  (define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
            sequence))

  (define (safe? k positions)
    ; k-1 already safe
    (let ((k-row (list-ref positions (- k 1))))
         ; whether k is in same row with 1..(k-1)
         (cond ((< (length (remove k-row positions))
                   (- k 1))
                #f)
               ; check whether k, k-1 conflict
               ((and (> k 1)
                     (= (abs
                          (- k-row
                             (list-ref positions (- k 2))))
                        1))
                #f)
               (else #t))))

  (length (queen-cols board-size)))

;; Exercise 2.43
;; TODO


