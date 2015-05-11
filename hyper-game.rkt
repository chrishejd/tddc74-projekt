#lang racket/gui
(require "brick.rkt")
(require "game-window-class.rkt")
(require "game-grid.rkt")
(require "highscore.rkt")
(require "wrong-key.rkt")
(require "gameboard.rkt")

(define key-var (void))

(define (render-hyper-game canvas dc)
  (define (move-bricks lst)
    (1))
  (define (refresh-timer)
    (send dc draw-bitmap grid-bitmap-3 0 0)
    (1)
    (send dc set-font (make-font #:size 20))
    (send dc draw-text 
          (string-append "Current score: " (number->string (send main-game-window get-score)))
          550 50))
  (cond
    [(void? key-var)
     (refresh-timer)]
    [(key-var) 
     (begin
       (move-bricks brick-lst)
       (refresh-timer))]
    [else (main-wrong-key)]))

(define (handle-keyboard-hyper key-event)
  (let ((key-code (send key-event get-key-code)))
    (cond
      [(eq? key-code 'release) (set! key-var (void))]
      [(eq? (char->integer key-code) (send (get-current brick-lst) get-key-code))
       (set! key-var #t)]
      [else (set! key-var #f)])))

(define hyper-canvas
  (new game-canvas%
       [parent hyper-window]
       [paint-callback render-hyper-game]
       [keyboard-handler handle-keyboard-hyper]))
