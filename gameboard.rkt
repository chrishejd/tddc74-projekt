#lang racket/gui
(require "brick.rkt")
(require "game-window-class.rkt")
(require "game-grid.rkt")

(define screen-length 800)
;;----------main gameboard----------

(define (render-game canvas dc)
  (define (change-brick-pos lst)
    (if (null? (cdr lst))
        (begin
          (send (car lst) offset-x-y-pos 0 100)
          (send (car lst) set-key-code!)
          (send (car lst) set-current)
          (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
          (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                (send (car lst) get-width) (send (car lst) get-height)))
        (begin
          (send (car lst) offset-x-y-pos 0 100)
          (send (car lst) set-key-code!)
          (send (car lst) set-current)
          (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
          (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                (send (car lst) get-width) (send (car lst) get-height))
          (change-brick-pos (cdr lst)))))
  (begin
    (send dc draw-bitmap grid-bitmap 0 0)
    (change-brick-pos brick-lst)))

;;Returns the brick at the bottom of the screen
(define (get-current lst)
  (cond
    ([send (car lst) is-current?]
      (car lst))
    (else (get-current (cdr lst)))))

;;Cancels gameplay
(define (wrong-key code)
  (void))

;;Refreshes the canvas if the key for the bottom brick is pressed. otherwise cancels gameplay
(define (handle-key-event key-event)
  (let ((key-code (send key-event get-key-code)))
    (cond
      ([eq? key-code 'release] (void))
      ([eq? (char->integer key-code) (send (get-current brick-lst) get-key-code)] ;;-48??? (ASCII)
        (send game-canvas refresh))
      (else
        (wrong-key key-code)))))
       
;;Game canvas to draw the main game on
(define game-canvas
  (new game-canvas%
    [parent main-game-window]
    [paint-callback render-game]
    [keyboard-handler handle-key-event]))

(send main-game-window show #t)
