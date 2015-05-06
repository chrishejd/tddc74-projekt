#lang racket/gui
(provide brick%)
(provide brick-lst)
(provide top-brick-coord)
(provide init-bricks)

(define top-brick-coord 0)
(define brick%
  (class object%
    (init-field x-pos y-pos width height color key-code current?)
    
    ;;Sets new x position
    (define/public (set-x-pos! new-pos)
      (set! x-pos new-pos))
    
    ;;Sets new y position
    (define/public (set-y-pos! new-pos)
      (set! y-pos new-pos))
    
    ;;Moves the brick x-offset in x axis, y-offset in y axis if the brick is at 
    ;;bottom, moves it up and on a random x position
    (define/public (offset-x-y-pos x-offset y-offset)
      (if (send this is-current?)
          (begin
            (set! x-pos (* 100 (+ (random 5) 0)))
            (set! y-pos top-brick-coord))
          (begin
            (set! x-pos (+ x-pos x-offset))
            (set! y-pos (+ y-pos y-offset)))))
    
    (define/public (set-rnd-x-pos)
      (set! x-pos (* 100 (+ (random 5) 0))))
    
    ;;Changes the color
    ;;(define/public (set-color! new-color)
    ;;(set! color new-color))
    
    ;;Offsets the size
    (define/public (offset-size offset)
      (begin
        (set! width (+ width offset))
        (set! height (+ height offset))))
    
    ;;Returns the x position
    (define/public (get-x-pos)
      x-pos)
    
    ;;Returns the y position
    (define/public (get-y-pos)
      y-pos)
    
    ;;Returns the height
    (define/public (get-height)
      height)
    
    ;;Returns the width
    (define/public (get-width)
      width)
    
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

;;----------Brick objects----------
(define brick1
  (new brick%
       [x-pos 0]
       [y-pos top-brick-coord]
       [height 100]
       [width 100]
       [color "black"]
       [key-code 49]
       [current? #f]))

(define brick2
  (new brick%
       [x-pos 100]
       [y-pos (+ 100 top-brick-coord)]
       [height 100]
       [width 100]
       [color "black"]
       [key-code 50]
       [current? #f]))

(define brick3
  (new brick%
       [x-pos 200]
       [y-pos (+ 200 top-brick-coord)]
       [height 100]
       [width 100]
       [color "black"]
       [key-code 51]
       [current? #f]))

(define brick4
  (new brick%
       [x-pos 300]
       [y-pos (+ 400 top-brick-coord)]
       [height 100]
       [width 100]
       [color "black"]
       [key-code 52]
       [current? #f]))

(define brick5
  (new brick%
       [x-pos 400]
       [y-pos (+ 300 top-brick-coord)]
       [height 100]
       [width 100]
       [color "black"]
       [key-code 53]
       [current? #f]))

(define brick6
  (new brick%
       [x-pos 300]
       [y-pos (+ 600 top-brick-coord)]
       [height 100]
       [width 100]
       [color "black"]
       [key-code 52]
       [current? #t]))

(define brick7
  (new brick%
       [x-pos 100]
       [y-pos (+ 500 top-brick-coord)]
       [height 100]
       [width 100]
       [color "black"]
       [key-code 49]
       [current? #f]))

;;List with all the brick objects
(define brick-lst
  (list brick1 brick2 brick3 brick4 brick5 brick6 brick7))

;;Too randomize the positions of the bricks
(define (init-bricks)
  (for-each 
   (lambda (brick-obj)
     (send brick-obj set-rnd-x-pos)
     (send brick-obj set-key-code!)
     (send brick-obj set-current)) 
   brick-lst))

