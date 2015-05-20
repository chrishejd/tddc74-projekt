#lang racket/gui
(require "highscore.rkt")
(provide grid)
(provide grid-bitmap)
(provide choose-bitmap)
(provide grid-edge)

(define grid-edge (void))
(define grid (void))
(define grid-bitmap (make-bitmap 800 1600))

;;Draws a grid of width size
(define (mk-grid size)
  (let ((dc (new bitmap-dc% [bitmap grid-bitmap]))
        (vert-size (* size 100)))
    ;;Draws the vertical lines
    (define (vert-lines-text col)
      (if (= 100 col)
          (begin
            (send dc set-font (make-font #:size 20))
            (send dc draw-text (number->string (/ col 100)) (- col 60) 725)
            (send dc draw-line col 0 col 750))
          (begin
            (send dc draw-line col 0 col 750)
            (vert-lines-text (- col 100))
            (send dc set-font (make-font #:size 20))
            (send dc draw-text (number->string (/ col 100)) (- col 60) 725))))

    
    (begin
      (send dc set-brush (make-object brush% "red" 'solid))
      (send dc draw-rectangle 0 0 vert-size 700)
      ;;Horizontal lines
      (send dc draw-line 0 0 vert-size 0)
      (send dc draw-line 0 100 vert-size 100)
      (send dc draw-line 0 200 vert-size 200)
      (send dc draw-line 0 300 vert-size 300)
      (send dc draw-line 0 400 vert-size 400)
      (send dc draw-line 0 500 vert-size 500)
      (send dc draw-line 0 600 vert-size 600)
      (send dc draw-line 0 700 vert-size 700)
      ;;Vertical lines
      (vert-lines-text vert-size))))

(define (choose-bitmap col)
  (set! grid-bitmap (make-bitmap 800 1600))
  (set! grid (mk-grid col))
  (set! grid-edge (* 100 col)))
