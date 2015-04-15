#lang racket/gui
(provide brick%)
(define brick%
  (class object%
      (init-field x-pos y-pos width height color)
      
      (define/public (set-x-pos! new-pos)
        (set! x-pos new-pos))
        
      (define/public (set-y-pos! new-pos)
        (set! y-pos new-pos))
        
      (define/public (set-color! new-color)
        (set! color new-color))
        
      (define/public (offset-size offset)
        (begin
          (set! width (+ width offset))
          (set! height (+ height offset))))
  (super-new)))
