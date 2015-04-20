#lang racket/gui
(provide game-window)

(define game-canvas%
  (class canvas%
    (init-field [keyboard-handler display])
    (define/override (on-char key-event)
      (keyboard-handler key-event)))
    (super-new))
    
