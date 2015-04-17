#lang racket/gui
(require "brick.rkt")

;;----------main gameboard----------

(define screen-length 800)



;;----------Grid----------

(define grid-bitmap (make-bitmap 800 1600))

;;Makes a bitmap grid in window
(define (mk-grid-bitmap target)
  (let ((dc (new bitmap-dc% [bitmap target])))
    (begin
      (send dc draw-line 100 0 100 700)
      (send dc draw-line 200 0 200 700)
      (send dc draw-line 300 0 300 700)
      (send dc draw-line 400 0 400 700)
      (send dc draw-line 500 0 500 700)
      ;;Horizontal lines
      (send dc draw-line 0 0 500 0)
      (send dc draw-line 0 100 500 100)
      (send dc draw-line 0 200 500 200)
      (send dc draw-line 0 300 500 300)
      (send dc draw-line 0 400 500 400)
      (send dc draw-line 0 500 500 500)
      (send dc draw-line 0 600 500 600)
      (send dc draw-line 0 700 500 700))))
(define grid
  (mk-grid-bitmap grid-bitmap))

(define (render-game canvas dc)
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
  (begin
    (send dc draw-bitmap grid-bitmap 0 0)
    (change-brick-pos brick-lst)))

;;Parent window for game-mode
(define main-game-window
  (new frame%
       [width 800]
       [height 799]
       [label "Inte nudda lava"]))
       
;;(define top-panel
;;  (new horizontal-panel%
;;    [parent main-game-window]))

(define bottom-panel
  (new horizontal-panel%
       [parent main-game-window]))

(define game-canvas
  (new canvas%
       [parent bottom-panel]
       [paint-callback render-game]))

(send main-game-window show #t)
