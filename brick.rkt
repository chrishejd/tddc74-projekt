#lang racket/gui
(provide brick%)
(provide brick-lst)
(provide top-brick-coord)
(define brick%
  (class object%
      (init-field x-pos y-pos width height color)
      
      (define/public (set-x-pos! new-pos)
        (set! x-pos new-pos))
        
      (define/public (set-y-pos! new-pos)
        (set! y-pos new-pos))
        
      (define/public (offset-x-y-pos x-offset y-offset)
        (begin
          (set! x-pos (+ x-pos x-offset))
          (set! y-pos (+ y-pos y-offset))))
        
      (define/public (set-color! new-color)
        (set! color new-color))
        
      (define/public (offset-size offset)
        (begin
          (set! width (+ width offset))
          (set! height (+ height offset))))
          
      (define/public (get-x-pos)
        x-pos)
        
      (define/public (get-y-pos)
      y-pos)
      
      (define/public (get-height)
        height)
      
      (define/public (get-width)
       width)
       
      (define/public (get-color)
      color)
       
  (super-new)))
  
  (define top-brick-coord -400)
  
  (define brick1
	(new brick%
		[x-pos 0]
		[y-pos top-brick-coord]
		[height 100]
		[width 100]
		[color "black"]))
		
(define brick2
	(new brick%
		[x-pos 100]
		[y-pos (+ 100 top-brick-coord)]
		[height 100]
		[width 100]
		[color "black"]))
		
(define brick3
	(new brick%
		[x-pos 200]
		[y-pos (+ 200 top-brick-coord)]
		[height 100]
		[width 100]
		[color "black"]))
		
(define brick4
	(new brick%
		[x-pos 300]
		[y-pos (+ 400 top-brick-coord)]
		[height 100]
		[width 100]
		[color "black"]))
		
(define brick5
	(new brick%
		[x-pos 400]
		[y-pos (+ 300 top-brick-coord)]
		[height 100]
		[width 100]
		[color "black"]))
		
(define brick-lst
	(list brick1 brick2 brick3 brick4 brick5))
