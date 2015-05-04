#lang racket/gui
(provide game-canvas%)
(provide main-game-window)
(provide wrong-key-window)

(define game-canvas%
  (class canvas%
    (init-field [keyboard-handler display])
    
    (define/override (on-char key-event)
      (keyboard-handler key-event))
    
    (super-new)))

(define game-frame%
  (class frame%
    (init-field curr-score)
    
    (define/public (get-score)
      curr-score)
    
    (define/public (inc-score)
      (set! curr-score (+ 1 curr-score)))
    
    (define/public (init-score)
      (set! curr-score 0))
    (super-new)))

;;Parent window for game-mode
(define main-game-window
  (new game-frame%
       [width 800]
       [height 799]
       [label "Don't touch the lava!"]
       [curr-score 0]))

(define wrong-key-window
  (new frame%
       [width 500]
       [height 299]
       [label "Don't touch the lava!"]))


    
