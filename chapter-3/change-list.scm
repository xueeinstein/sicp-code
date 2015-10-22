;;; Bill Xue
;;; 2015-10-21
;;; Change Elements in List

;; Exercise 3.12
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x (list 'a 'b))

(define y (list 'c 'd))

(define z (append x y))

; 'append' doesn't chang x and y
; so (cdr x) gets (b)

(define w (append! x y))

; append! changed x value
; so (cdr x) gets (b c d)

; the model is:
;           +----+----+     +----+----+
; w +------->    |    |     |    |    |
; x +-------> +  |  +-------> +  |  + |
;           +----+----+     +----+----+
;             |              |     |
;             |              |     |
;             v              v     |
;             a              b     |
;                                  |
;                                  |  +---+---+     +---+---+
;                                  +-->   |   |     |   |   |
;                            y +------> + |   +-----> + |   |
;                                     +---+---+     +---+---+
;                                       |             |
;                                       v             v
;                                       c             d

;; Exercise 3.13
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

;  +-----------------------------------------------------+
;  |                                                     |
;  |        +----+----+     +----+----+    +----+----+   |
;  +-------->    |    |     |    |    |    |    |    |   |
; x +------->  + |  +-------> +  |    +---->  + |    +---+
;           +----+----+     +----+----+    +----+----+
;              |              |               |
;              |              |               |
;              v              v               v
;              a              b               c

; Try to get (last-pair z) would cause infinity loop

;; Exercise 3.14
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))

  (trace loop) ; for better trace
  (loop x '()))

(define v (list 'a 'b 'c 'd))

; The mode of v:
;
;         +----+----+    +----+----+    +----+----+    +----+---+
;         >    |    |    |    |    |    |    |    |    |    |   |
; v +----->  + |  +------> +  |    +---->  + |    +---->  + |   |
;         +----+----+    +----+----+    +----+----+    +----+---+
;            |             |               |              |
;            |             |               |              |
;            v             v               v              v
;            a             b               c              d

(trace mystery)
(define w (mystery v))

; The trace of w define
; > (mystery '(a b c d))
; > (loop '(a b c d) '())
; > (loop '(b c d) '(a))
; > (loop '(c d) '(b a))
; > (loop '(d) '(c b a))
; > (loop '() '(d c b a))
; (d c b a)

; currently, the model is:
;                               v +-------+
;                                         |
;                                         |
;         +--+--+    +--+--+   +--+--+   +v-+--+
; w +----->  |  +---->  |  +--->  |  +--->  |  |
;         ++-+--+    ++-+--+   ++-+--+   ++-+--+
;          |          |         |         |
;          v          v         v         v
;          d          c         b         a

;; Exercise 3.15
(define x (list 'a 'b))
(define z1 (cons x x))
(define z2 (cons (list 'a 'b) (list 'a 'b)))
(define (set-to-wow! x)
  (set-car! (car x) 'wow)
  x)

(set-to-wow! z1)
; The model of z1 change 'a to 'wow
;        +--+--+
; z1+---->  |  |
;        ++-+-++
;         |   |
;         |   |
;        +v-+-v+   +--+--+
; x +---->  |  +--->  |  |
;        ++-+--+   ++-+--+
;         |         |
;         v         v
;         wow       b

(set-to-wow! z2)

; The model of z2:
;        +--+--+    +--+--+    +--+--+
; z2+---->  |  +---->  |  +---->  |  |
;        ++-+--+    ++-+--+    +-++--+
;         |          |           |
;         |          v           v
;         |           a           b
;         |                      ^
;         |         +--+--+    +-++--+
;         +--------->  |  |    |  |  |
;                   ++-+--+    +--+--+
;                    |
;                    v
;                     wow

;; Exercise 3.16
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(count-pairs (cons (cons 1 2) (cons 3 4)))  ; get 3 pairs
(count-pairs '((a b) c)) ; get 4
(count-pairs '(((a) (b)) (c))) ; get 7
; 7 pair model:
; (total 7 box)
;              +--+--+                +--+--+
; pair-7  +---->  |  +---------------->  |  |
;              ++-+--+                +-++--+
;               |                       |
;               |                       |
;              +v-+--+   +--+--+      +-v+--+
;              |  |  +--->  |  |      |  |  |
;              ++-+--+   ++-+--+      +-++--+
;               |         |             |
;               |         |             v
;              +v-+--+   +v-+--+        c
;              |  |  |   |  |  |
;              ++-+--+   ++-+--+
;               |         |
;               v         v
;               a         b


;; Exercise 3.17
;; here, we use binary tree to record traced boxes
(define (count-pairs-me x)
  (define records (list #f))

  (define (add-one i)
    (if i 0 1))

  (define (traverse x trace)
    (let ((is-traced (car trace)))
      (begin
        ; mark current box traced
        (set-car! trace #t)
        ; mark car and cdr box untraced
        (set-cdr! trace '((#f) (#f)))
        (if (not (pair? x))
            0
            (+ (traverse (car x) (cadr trace))
               (traverse (cdr x) (caddr trace))
               (add-one is-traced))))))

  (trace traverse)
  (traverse x records))
