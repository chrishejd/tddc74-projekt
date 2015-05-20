#lang racket/gui
(require "game-window-class.rkt")
(require "brick.rkt")
(require "game-grid.rkt")
(require "highscore.rkt")

;;----------Canvas callbacks----------

(define (render-start-menu canvas dc)
  (send dc set-font (make-font #:size 20))
  (send dc draw-text "welcome to..." 160 20)
  (send dc set-font (make-font #:size 28 #:underlined? #t))
  (send dc draw-text "DON'T TOUCH THE LAVA!" 15 70 "black"))

(define (render-tutorial canvas dc)
  (send dc set-font (make-font #:size 25 #:underlined? #t))
  (send dc draw-text "Tutorial" 230 30))

(define (render-credits canvas dc)
  (send dc set-font (make-font #:size 32 #:underlined? #t))
  (send dc draw-text "Credits:" 215 30)
  (send dc set-font (make-font #:size 20 #:underlined? #t))
  (send dc draw-text "Developed and programmed by:" 10 120)
  (send dc set-font (make-font #:size 18))
  (send dc draw-text "- Christoffer Hejdström" 120 200)
  (send dc draw-text "- Jonatan Gustafsson" 120 240)
  (send dc set-font (make-font #:size 12))
  (send dc draw-text "In a project in the course TDDC74, Linköping University spring 2015." 20 340))

;;----------Canvases----------

(define menu-canvas
  (new canvas%
       [parent menu-window]
       [paint-callback render-start-menu]))

(define tutorial-canvas
  (new canvas%
       [parent tutorial-window]
       [paint-callback render-tutorial]))

(define credits-canvas
  (new canvas%
       [parent credits-window]
       [paint-callback render-credits]))

;;----------Main Menu Buttons----------

(define casual-button
  (new button%
       [parent menu-window]
       [label "casual..."]
       [callback (lambda (button event)
                   (set-curr-win 'casual)
                   (send curr-win init-score)
                   (load-highscore 'classic)
                   (set-column-size 5)
                   (choose-bitmap 5)
                   (send menu-window show #f)
                   (send main-game-window show #t)
                   (send main-game-window refresh)
                   (send start-window show #t))]))

(define hyper-button
  (new button%
       [parent menu-window]
       [label "HYPER!!!"]
       [callback (lambda (button event)
                   (set-curr-win 'hyper)
                   (send curr-win init-score)
                   (load-highscore 'hyper)
                   (set-column-size 3)
                   (choose-bitmap 3)
                   (send menu-window show #f)
                   (send hyper-window show #t)
                   (send hyper-window refresh)
                   (send start-window show #t))]))

(define tutorial-button
  (new button%
       [parent menu-window]
       [label "Tutorial!!!"]
       [callback (lambda (button event)
                   (send tutorial-window show #t))]))

(define credits-button
  (new button%
       [parent menu-window]
       [label "Credits!!!"]
       [callback (lambda (button event)
                   (send credits-window show #t))]))

;;----------Close Buttons----------

(define close-tutorial-button
  (new button%
       [parent tutorial-window]
       [label "Close"]
       [callback (lambda (button event)
                   (send tutorial-window show #f))]))

(define close-credits-button
  (new button%
       [parent credits-window]
       [label "Close"]
       [callback (lambda (button event)
                   (send credits-window show #f))]))
