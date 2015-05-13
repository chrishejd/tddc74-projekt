#lang racket/gui
(require "brick.rkt")
(require "game-window-class.rkt")
(require "game-grid.rkt")
(require "highscore.rkt")
(require "wrong-key.rkt")
(provide render-game)
(provide handle-key-event)

(define screen-length 800)
;;----------main gameboard----------(send main-game-window show #t)

;;Draws the bricks
(define (render-game canvas dc)
  ;;Moves the bricks one position down
  (define (change-brick-pos lst)
    (if (null? (cdr lst))
        (begin
          (send (car lst) offset-x-y-pos 0 100)
          (send (car lst) set-key-code!)
          (send (car lst) set-current)
          (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
          (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                (send (car lst) get-size) (send (car lst) get-size)))
        (begin
          (send (car lst) offset-x-y-pos 0 100)
          (send (car lst) set-key-code!)
          (send (car lst) set-current)
          (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
          (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                (send (car lst) get-size) (send (car lst) get-size))
          (change-brick-pos (cdr lst)))))
  (begin
    (send dc draw-bitmap grid-bitmap 0 0)
    (change-brick-pos brick-lst)
    (send dc set-font (make-font #:size 20))
    (send dc draw-text 
          (string-append "Current score: " (number->string (send main-game-window get-score)))
          550 50)
    (send dc draw-text "Highscore" 550 300)
    (send dc draw-text (send classic-highscore rank->string 1) 550 330)
    (send dc draw-text (send classic-highscore rank->string 2) 550 360)
    (send dc draw-text (send classic-highscore rank->string 3) 550 390)
    (send dc draw-text (send classic-highscore rank->string 4) 550 420)
    (send dc draw-text (send classic-highscore rank->string 5) 550 450)
    (send dc draw-text (send classic-highscore rank->string 6) 550 480)
    (send dc draw-text (send classic-highscore rank->string 7) 550 510)
    (send dc draw-text (send classic-highscore rank->string 8) 550 540)
    (send dc draw-text (send classic-highscore rank->string 9) 550 570)
    (send dc draw-text (send classic-highscore rank->string 10) 550 600)))

;;Returns the brick at the bottom of the screen
(define (get-current lst)
  (cond
    ([send (car lst) is-current?]
     (car lst))
    (else (get-current (cdr lst)))))

;;Cancels gameplay
(define (wrong-key code)
  (send classic-highscore update-score! (send main-game-window get-score))
  (send classic-highscore save-highscore)
  (main-wrong-key))

;;Refreshes the canvas if the key for the bottom brick is pressed. otherwise cancels gameplay
(define (handle-key-event key-event)
  (let ((key-code (send key-event get-key-code)))
    (cond
      ([eq? key-code 'release] (void))
      ([eq? (char->integer key-code) (send (get-current brick-lst) get-key-code)]
       (begin
         (send main-game-window inc-score)
         (send game-canvas refresh)
         (send hyper-canvas refresh)))
      (else
       (wrong-key key-code)))))

;;Game canvas to draw the main game on
(define game-canvas
  (new game-canvas%
       [parent main-game-window]
       [paint-callback render-game]
       [keyboard-handler handle-key-event]))

(define hyper-canvas
  (new game-canvas%
       [parent hyper-window]
       [paint-callback render-game]
       [keyboard-handler handle-key-event]))

