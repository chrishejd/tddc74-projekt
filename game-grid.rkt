#lang racket/gui
(require "highscore.rkt")
(provide mk-grid-bitmap)
(provide grid)
(provide grid-bitmap)
(provide choose-bitmap)

(define grid-bitmap (void))
(define grid (void))

(define grid-bitmap-5 (make-bitmap 800 1600))

(define (mk-grid-bitmap target)
  (let ((dc (new bitmap-dc% [bitmap target])))
    (begin
      (send dc set-brush (make-object brush% "red" 'solid))
      (send dc draw-rectangle 0 0 500 700)
      (send dc draw-line 100 0 100 750)
      (send dc draw-line 200 0 200 750)
      (send dc draw-line 300 0 300 750)
      (send dc draw-line 400 0 400 750)
      (send dc draw-line 500 0 500 750)
      ;;Horizontal lines
      (send dc draw-line 0 0 500 0)
      (send dc draw-line 0 100 500 100)
      (send dc draw-line 0 200 500 200)
      (send dc draw-line 0 300 500 300)
      (send dc draw-line 0 400 500 400)
      (send dc draw-line 0 500 500 500)
      (send dc draw-line 0 600 500 600)
      (send dc draw-line 0 700 500 700)
      (send dc set-font (make-font #:size 20))
      (send dc draw-text "1" 40 725)
      (send dc draw-text "2" 140 725)
      (send dc draw-text "3" 240 725)
      (send dc draw-text "4" 340 725)
      (send dc draw-text "5" 440 725))))

(define grid-5 (mk-grid-bitmap grid-bitmap-5))

(define grid-bitmap-3 (make-bitmap 800 1600))

(define (mk-grid-bitmap-3 target)
  (let ((dc (new bitmap-dc% [bitmap target])))
    (begin
      (send dc set-brush (make-object brush% "red" 'solid))
      (send dc draw-rectangle 0 0 300 700)
      (send dc draw-line 100 0 100 750)
      (send dc draw-line 200 0 200 750)
      (send dc draw-line 300 0 300 750)
      ;;Horizontal lines
      (send dc draw-line 0 0 500 0)
      (send dc draw-line 0 100 300 100)
      (send dc draw-line 0 200 300 200)
      (send dc draw-line 0 300 300 300)
      (send dc draw-line 0 400 300 400)
      (send dc draw-line 0 500 300 500)
      (send dc draw-line 0 600 300 600)
      (send dc draw-line 0 700 300 700)
      (send dc set-font (make-font #:size 20))
      (send dc draw-text "1" 40 725)
      (send dc draw-text "2" 140 725)
      (send dc draw-text "3" 240 725))))

(define grid-3 (mk-grid-bitmap-3 grid-bitmap-3))

(define (choose-bitmap columns)
  (cond
    ((= 5 columns) 
     (set! grid-bitmap grid-bitmap-5)
     (set! grid grid-5))
    ((= 3 columns)
     (set! grid-bitmap grid-bitmap-3)
     (set! grid grid-3))))
