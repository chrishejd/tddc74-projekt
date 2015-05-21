#lang racket/gui

;;Purpose: Controls what happens when wrong key on the keyboard is pressed
;;Authors: Christoffer Hejdström (chrhe465) and Jonatan Gustafsson (jongu926)
;;Last change: Updated with new modular highscore and game modes, 2015-05-20

(require "game-window-class.rkt")
(require "highscore.rkt")
(require "timer-start-window.rkt")

(provide main-wrong-key)

;;----------Canvas Drawing Function----------

(define (render-wrong-key canvas dc)
  (let ((score (send curr-win get-score)))
    (send dc set-font (make-font #:size 20))
    (send dc draw-text "You died!" 200 50)
    (send dc draw-text 
          (string-append (string-append "You stepped on " (number->string 
                                                           score)) 
                         " blocks.") 90 100)))

;;----------Canvas For Wrong Key----------

(define wrong-key-canvas
  (new canvas%
       [parent wrong-key-window]
       [paint-callback render-wrong-key]))

;;----------Main Function For Pressing The Wrong Key---------- 

;;Saves score if it is good enough, stops timer etc.
(define (main-wrong-key score)
  (send timer stop)
  (send main-game-window show #f)
  (send hyper-window show #f)
  (send highscore update-score! score)
  (send highscore save-highscore)
  (send wrong-key-window show #t)
  (send wrong-key-window refresh))

;;----------Buttons----------

;;Restarts the game with the same mode
(define retry-button
  (new button%
       [parent wrong-key-window]
       [label "Play again"]
       [callback (lambda (button event)
                   (send curr-win init-score)
                   (send wrong-key-window show #f)
                   (send curr-win show #t)
                   (send curr-win refresh)
                   (send start-window show #t))]))

;;Back to main menu
(define main-menu-button
  (new button%
       [parent wrong-key-window]
       [label "Main menu"]
       [callback (lambda (button event)
                   (send wrong-key-window show #f)
                   (send menu-window show #t))]))
