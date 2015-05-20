#lang racket/gui
(require "game-window-class.rkt")
(require "highscore.rkt")
(require "timer-start-window.rkt")
(provide main-wrong-key)

(define (render-wrong-key canvas dc)
  (let ((score (send curr-win get-score)))
    (send dc set-font (make-font #:size 20))
    (send dc draw-text "You died!" 200 50)
    (send dc draw-text 
          (string-append (string-append "You stepped on " (number->string 
                                                           score)) 
                         " blocks.")
          90 100)))

;;Canvas for failed game
(define wrong-key-canvas
  (new canvas%
       [parent wrong-key-window]
       [paint-callback render-wrong-key]))

;;Main function for pressing the wrong key
(define (main-wrong-key score)
  (send timer stop)
  (send main-game-window show #f)
  (send hyper-window show #f)
  (send highscore update-score! score)
  (send highscore save-highscore)
  (send wrong-key-window show #t)
  (send wrong-key-window refresh))

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

(define exit-button
  (new button%
       [parent wrong-key-window]
       [label "Main menu"]
       [callback (lambda (button event)
                   (send wrong-key-window show #f)
                   (send menu-window show #t))]))
