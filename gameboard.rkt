#lang racket/gui
(require "brick.rkt")
(require "game-window-class.rkt")

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
          (send (car lst) set-current)
          (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
          (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                (send (car lst) get-width) (send (car lst) get-height)))
        (begin
          (send (car lst) offset-x-y-pos 0 100)
          (send (car lst) set-current)
          (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
          (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                (send (car lst) get-width) (send (car lst) get-height))
          (change-brick-pos (cdr lst)))))
  (begin
    ;;(send dc set-background "red")
    (send dc draw-bitmap grid-bitmap 0 0)
    (change-brick-pos brick-lst)))

;;Returns the brick at the bottom of the screen
(define (get-current lst)
  (cond
    ([send (car lst) is-current?]
      (car lst))
    (else (get-current (cdr lst)))))

;;Cancels gameplay
(define (wrong-key)
  (void))

;;Refreshes the canvas if the key for the bottom brick is pressed. otherwise cancels gameplay
(define (handle-key-event key-event)
  (let ((key-code (send key-event get-key-code)))
    (cond
      ([eq? key-code (send (get-current brick-lst) get-key-code)] ;;-48??? (ASCII)
        (send game-canvas refresh))
      (else
        (wrong-key)))))

;;Parent window for game-mode
(define main-game-window
  (new frame%
       [width 800]
       [height 799]
       [label "Inte nudda lava"]))
       
(define game-canvas
  (new game-canvas%
    [parent main-game-window]
    [paint-callback render-game]
    [keyboard-handler handle-key-event]))

(send main-game-window show #t)
