;;; Bill Xue
;;; 2015-10-11
;;; A Graph Lang with Closure


(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

;; Abstract filpped-pairs and square-limit
(define (square-of-four tl tr bl br)
  ; tl: top left copyed painter
  ; tr: top right copyed painter
  ; ...
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

;; Then rewrite filpped-pairs and square-limit
(define (flipped-pairs-new painter)
  ((square-of-four identity flip-vert identity flip-vert)
   painter))

(define (square-limit painter n)
  ((square-of-four flip-horiz identity rotate180 flip-vert)
   (corner-split painter n)))

;; for frame, review Exercise 2.47
;; for vector operations, review Exercise 2.46
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcor-vect v)
                            (edge1-frame frame))
                (scale-vect (ycor-vect v)
                            (edge2-frame frame))))))

;; draw segments beyond draw line
;; make a painter who can draw segments on given frame
;; for segment operations, review Exercise 2.48
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line
          ((frame-coord-map frame) (start-segment segment))
          ((frame-coord-map frame) (end-segment segment))))
      segment-list)))

;; Abstract for painter transform
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
          (make-frame new-origin
                      (sub-vect (m corner1) new-origin)
                      (sub-vect (m corner2) new-origin)))))))

;; Then define flip-vert
(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)      ; new origin
                     (make-vect 1.0 1.0)      ; new end of edge1
                     (make-vect 0.0 0.0)))    ; new end of edge2

(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1.0 0.5)
                     (make-vect 0.5 1.0)))


(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))


(define (squash-inwards painter)
  (transform-painter painter
                     (make-vect 0.0 0.0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))

;; define beside
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left       ; paint painter1 on left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right      ; paint painter2 on right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

;; ====================
;; Exercises
;; ====================

;; Exercise 2.44
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

;; Exercise 2.45
(define (split split-first split-second)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split split-first split-second)
                        painter
                        (- n 1))))
          (split-first painter (split-second smaller smaller))))))

;; Exercise 2.46
(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cadr v))

(define (add-vect v w)
  (make-vect (+ (xcor-vect v) (xcor-vect w))
             (+ (ycor-vect v) (ycor-vect w))))

(define (sub-vect v w)
  (make-vect (- (xcor-vect v) (xcor-vect w))
             (- (ycor-vect v) (ycor-vect w))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

;; Exercise 2.47
;;
;; version 1
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (list-ref frame 2))

;; version 2
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cadr frame)))

(define (edge2-frame frame)
  (cadr (cadr frame)))

;; Exercise 2.48
;; segment
(define (make-segment v w)
  (cons v w))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cadr segment))

;; Exercise 2.49

;; painter who draw the board of the frame
(define painter-a
  (segments->painter
    '(((0 0) (1 0)) ((1 0) (1 1)) ((1 1) (0 1)) ((0 1) (0 0)))))

;; painter who connect two corner of the frame, got big X
(define painter-b
  (segments->painter
    '(((0 0) (1 1)) ((0 1) (1 0)))))

;; painter-c and painter-d
;; we can do it in the same way
;; passed


;; Exercise 2.50
;; flip-horiz

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

;; anti-timer 180 rotation and 270 rotation
(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

;; Exercise 2.51
;; define below

;; version 1
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom
            (transform-painter painter1
                               (make-vect 0.0 0.0)
                               (make-vect 1.0 0.0)
                               split-point))
          (paint-top
            (transform-painter painter2
                               split-point
                               (make-vect 1.0 0.0)
                               (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))

;; version 2, by rotating beside
(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))

;; Exercise 2.52
;; TODO: integrate this Graph lang with js canvas
