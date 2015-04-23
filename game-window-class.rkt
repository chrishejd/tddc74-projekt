#lang racket/gui
(provide game-canvas%)
(provide main-game-window)

(define game-canvas%
  (class canvas%
    (init-field [keyboard-handler display])
    
    (define/override (on-char key-event)
      (keyboard-handler key-event))
    
    (super-new)))

;;Parent window for game-mode
(define main-game-window
  (new frame%
       [width 800]
       [height 799]
       [label "Inte nudda lava"]))


    
