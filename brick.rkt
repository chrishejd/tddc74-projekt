#lang racket/gui
(provide brick%)
(provide brick-lst)
(provide top-brick-coord)
(provide set-column-size)

(define top-brick-coord 0)
(define std-size 100)
(define std-num-bricks 7)

(define brick%
  (class object%
    (init-field x-pos y-pos size color key-code current? columns)
    
    ;;Sets new x position
    (define/public (set-x-pos! new-pos)
      (set! x-pos new-pos))
    
    (define/public (get-x-pos)
      x-pos)
    
    ;;Sets new y position
    (define/public (set-y-pos! new-pos)
      (set! y-pos new-pos))
    
    ;;Moves the brick x-offset in x axis, y-offset in y axis if the brick is at 
    ;;bottom, moves it up and on a random x position
    (define/public (offset-x-y-pos x-offset y-offset)
      (if (send this is-current?)
          (begin
            (set! x-pos (* 100 (+ (random columns) 0)))
            (set! y-pos top-brick-coord))
          (begin
            (set! x-pos (+ x-pos x-offset))
            (set! y-pos (+ y-pos y-offset)))))
    
    (define/public (set-rnd-x-pos)
      (set! x-pos (* 100 (+ (random columns) 0))))
    
    ;;Changes the color
    ;;(define/public (set-color! new-color)
    ;;(set! color new-color))
    
    ;;Offsets the size
    (define/public (offset-size offset)
      (begin
        (set! size (+ size offset))))
    
    (define/public (set-size! new-size)
      (set! size new-size))
    
    (define/public (get-size)
      size)
    
    ;;Returns the y position
    (define/public (get-y-pos)
      y-pos)
    
    
    ;;Returns the color
    (define/public (get-color)
      color)
    
    (define/public (get-key-code)
      key-code)
    
    (define/public (is-current?)
      current?)
    
    (define/public (set-key-code!)
      (set! key-code (+ (/ x-pos 100) 49)))
    
    (define/public (set-current)
      (if (= y-pos (+ 600 top-brick-coord))
          (set! current? #t)
          (set! current? #f)))
    
    (super-new)))

;;Creates a list of brick objects
(define (make-brick-lst size num-of-bricks x-columns)
  (define (loop x y counter)
    (if (= 0 counter)
        '()
        (begin
          (cons (new brick%
                     [x-pos x]
                     [y-pos y]
                     [size std-size]
                     [color "black"]
                     [key-code (+ (/ x 100) 49)]
                     [current? #f]
                     [columns x-columns])
                (loop 100 (+ y 100) (- counter 1))))))
  (loop 0 0 num-of-bricks))

(define brick-lst '())

;;Too randomize the positions of the bricks
(define (init-bricks)
  (for-each 
   (lambda (brick-obj)
     (send brick-obj set-rnd-x-pos)
     (send brick-obj set-key-code!)
     (send brick-obj set-current)) 
   brick-lst))

(define (set-column-size size)
  (begin
    (set! brick-lst (make-brick-lst std-size std-num-bricks size))
    (printf "~a" brick-lst)
    (init-bricks)))
