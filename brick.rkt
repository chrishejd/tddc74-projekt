#lang racket/gui
(provide brick%)
(provide brick-lst)
(provide top-brick-coord)
(define brick%
  (class object%
      (init-field x-pos y-pos width height color)
      
      ;;Sets new x position
      (define/public (set-x-pos! new-pos)
        (set! x-pos new-pos))
        
  		;;Sets new y position
      (define/public (set-y-pos! new-pos)
        (set! y-pos new-pos))
        
      ;;Moves the brick x-offset in x axis, y-offset in y axis
      (define/public (offset-x-y-pos x-offset y-offset)
        (begin
          (set! x-pos (+ x-pos x-offset))
          (set! y-pos (+ y-pos y-offset))))
       
      ;;Changes the color
      (define/public (set-color! new-color)
        (set! color new-color))
      
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
       
  (super-new)))
  
  (define top-brick-coord -200)
  
  ;;----------Brick objects----------
  (define brick1
	(new brick%
		[x-pos 0]
		[y-pos top-brick-coord]
		[height 100]
		[width 100]
		[color "red"]))
		
(define brick2
	(new brick%
		[x-pos 100]
		[y-pos (+ 100 top-brick-coord)]
		[height 100]
		[width 100]
		[color "red"]))
		
(define brick3
	(new brick%
		[x-pos 200]
		[y-pos (+ 200 top-brick-coord)]
		[height 100]
		[width 100]
		[color "red"]))
		
(define brick4
	(new brick%
		[x-pos 300]
		[y-pos (+ 400 top-brick-coord)]
		[height 100]
		[width 100]
		[color "red"]))
		
(define brick5
	(new brick%
		[x-pos 400]
		[y-pos (+ 300 top-brick-coord)]
		[height 100]
		[width 100]
		[color "red"]))

(define brick6
	(new brick%
		[x-pos 300]
		[y-pos (+ 600 top-brick-coord)]
		[height 100]
		[width 100]
		[color "red"]))

(define brick7
	(new brick%
		[x-pos 100]
		[y-pos (+ 500 top-brick-coord)]
		[height 100]
		[width 100]
		[color "red"]))

;;List with all the brick objects
(define brick-lst
	(list brick1 brick2 brick3 brick4 brick5 brick6 brick7))

