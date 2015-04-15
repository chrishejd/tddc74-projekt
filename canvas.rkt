#lang racket/gui
(require "brick.rkt")

(define screen-length 800)

(define main-window
	(new frame%
		[width 800]
		[height 1600]
		[label "Inte nudda lava"]))
		
(define (render-fn canvas dc)
	(define (change-brick-pos lst)
		(if (null? (cdr lst))
				(begin
					(send (car lst) offset-x-y-pos 0 100)
					(send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
					(send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
																	(send (car lst) get-width) (send (car lst) get-height)))
				(begin
					(send (car lst) offset-x-y-pos 0 100)
					(send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
					(send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
																	(send (car lst) get-width) (send (car lst) get-height))
					(change-brick-pos (cdr lst)))))
	(change-brick-pos brick-lst))
	
(define (draw-grid canvas dc)
	(begin
		;;Vertical lines
		(send dc draw-line 100 0 100 1000)
		(send dc draw-line 200 0 200 1000)
		(send dc draw-line 300 0 300 1000)
		(send dc draw-line 400 0 400 1000)
		(send dc draw-line 500 0 500 1000)
		;;Horizontal lines
		(send dc draw-line 0 100 500 100)
		(send dc draw-line 0 200 500 200)
		(send dc draw-line 0 300 500 300)
		(send dc draw-line 0 400 500 400)
		(send dc draw-line 0 500 500 500)))
		
(define grid-canvas
	(new canvas%
		[parent main-window]
		[paint-callback draw-grid]))
		
(define game-canvas
	(new canvas%
		[parent main-window]
		[style 'transparent]
		[paint-callback render-fn]))

(draw-grid)
(send main-window show #t)
;;Va konstiga tabbar
