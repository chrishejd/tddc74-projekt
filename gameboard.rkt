#lang racket/gui

;;Purpose: Graphics for the gameboard, which the game is played on 
;;Authors: Christoffer Hejdström (chrhe465) and Jonatan Gustafsson (jongu926)
;;Last change: Made "render-game" more modular, 2015-05-21

(require "brick.rkt")
(require "game-window-class.rkt")
(require "game-grid.rkt")
(require "highscore.rkt")
(require "wrong-key.rkt")

(provide render-game)
(provide handle-key-event)

(define screen-length 800)

;;----------Main Paint Callback----------

;;Draws the bricks, the grid and the highscore
(define (render-game canvas dc)
  ;;Moves the bricks one position down, which is (+ 100 y-pos)
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
            (string-append "Current score: " (number->string (send curr-win get-score)))
            (+ grid-edge 50) 50)
      (send dc draw-text "Highscore" (+ grid-edge 50) 300)
      (send dc draw-text (send highscore rank->string 1) (+ grid-edge 50) 330)
      (send dc draw-text (send highscore rank->string 2) (+ grid-edge 50) 360)
      (send dc draw-text (send highscore rank->string 3) (+ grid-edge 50) 390)
      (send dc draw-text (send highscore rank->string 4) (+ grid-edge 50) 420)
      (send dc draw-text (send highscore rank->string 5) (+ grid-edge 50) 450)
      (send dc draw-text (send highscore rank->string 6) (+ grid-edge 50) 480)
      (send dc draw-text (send highscore rank->string 7) (+ grid-edge 50) 510)
      (send dc draw-text (send highscore rank->string 8) (+ grid-edge 50) 540)
      (send dc draw-text (send highscore rank->string 9) (+ grid-edge 50) 570)
      (send dc draw-text (send highscore rank->string 10) (+ grid-edge 50) 600)))
  
  ;;Returns the brick at the bottom of the screen
  (define (get-current lst)
    (cond
      ([send (car lst) is-current?]
       (car lst))
      (else (get-current (cdr lst)))))

;;----------Keyboard functions----------

  ;;Cancels gameplay if wrong key code
  (define (wrong-key code)
    (main-wrong-key (send curr-win get-score)))

  ;;Refreshes the canvas if the key for the bottom brick is pressed, otherwise cancels gameplay
  (define (handle-key-event key-event)
    (let ((key-code (send key-event get-key-code)))
      (cond
        ([eq? key-code 'release] (void))
        ([char? key-code]
         (if [eq? (char->integer key-code) (send (get-current brick-lst) get-key-code)]
             (begin
               (send curr-win inc-score)
               (send game-canvas refresh)
               (send hyper-canvas refresh))
             (wrong-key key-code)))
        (else
         (error "Pressed key not valid key-event:" key-code)))))

;;----------Canvases----------

  ;;Game canvas for the casual game mode
  (define game-canvas
    (new game-canvas%
         [parent main-game-window]
         [paint-callback render-game]
         [keyboard-handler handle-key-event]))
  
  ;;Game canvas for the hyper game mode
  (define hyper-canvas
    (new game-canvas%
         [parent hyper-window]
         [paint-callback render-game]
         [keyboard-handler handle-key-event]))
  
  
