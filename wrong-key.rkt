#lang racket/gui
(require "game-window-class.rkt")
(provide main-wrong-key)

(define (render-wrong-key canvas dc)
  (let ((score (send main-game-window get-score)))
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

(define (main-wrong-key)
  (send main-game-window show #f)
  (send wrong-key-window show #t)
  (send wrong-key-window refresh))

(define retry-button
  (new button%
       [parent wrong-key-window]
       [label "Retry"]
       [callback (lambda (button event) 
                   (send wrong-key-window show #f)
                   (send main-game-window show #t)
                   (send main-game-window refresh)
                   (send main-game-window init-score))]))

(define exit-button
  (new button%
       [parent wrong-key-window]
       [label "Exit"]))
