#lang racket/gui
(require "game-window-class.rkt")

;;Canvas callback
(define (render-start-menu canvas dc)
  (send dc set-font (make-font #:size 20))
  (send dc draw-text "really. fun. game. right. here." 10 20))

;;Button event functions
(define (tutorial-func button event)
  (void))

(define (roll-credits button event)
  (void))

;;Canvas
(define menu-canvas
  (new canvas%
       [parent menu-window]
       [paint-callback render-start-menu]))

;;Buttons
(define start-button
  (new button%
       [parent menu-window]
       [label "Play Game!!!"]
       [callback (lambda (button event) 
                   (send menu-window show #f)
                   (send main-game-window show #t)
                   (send main-game-window refresh)
                   (send main-game-window init-score)
                   (send start-window show #t))]))

(define tutorial-button
  (new button%
       [parent menu-window]
       [label "Tutorial!!!"]
       [callback tutorial-func]))

(define credits-button
  (new button%
       [parent menu-window]
       [label "Credits!!!"]
       [callback roll-credits]))
