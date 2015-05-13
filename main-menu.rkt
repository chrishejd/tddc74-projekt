#lang racket/gui
(require "game-window-class.rkt")
(require "brick.rkt")
(require "game-grid.rkt")

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
       [label "casual..."]
       [callback (lambda (button event)
                   (set-column-size 5)
                   (choose-bitmap 5)
                   (send menu-window show #f)
                   (send main-game-window show #t)
                   (send main-game-window refresh)
                   (send main-game-window init-score)
                   (send start-window show #t))]))

(define mode-button
  (new button%
       [parent menu-window]
       [label "HYPER!!!"]
       [callback (lambda (button event) 
                   (set-column-size 3)
                   (choose-bitmap 3)
                   (send menu-window show #f)
                   (send hyper-window show #t)
                   (send hyper-window refresh)
                   (send hyper-window init-score)
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
