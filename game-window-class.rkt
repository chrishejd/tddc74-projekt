#lang racket/gui

(define game-window
  (class object%
    [init-field (grid [make-bitmap 100 100]
                      [x 0]
                      [y 0])]
                      
    (define/public (render-game canvas dc)
      (define (change-brick-pos lst)
        (if (null? (cdr lst))
          (begin
            (send (car lst) offset-x-y-pos 0 100)
            (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
            (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                 (send (car lst) get-width) (send (car lst) get-height)))
          (begin
            (send (car lst) offset-x-y-pos 0 100)
            (send dc set-brush (make-object brush% (send (car lst) get-color) 'solid))
            (send dc draw-rectangle (send (car lst) get-x-pos) (send (car lst) get-y-pos)
                  (send (car lst) get-width) (send (car lst) get-height))
            (change-brick-pos (cdr lst)))))
      (begin
        (send dc set-background "red")
        (send dc draw-bitmap grid-bitmap 0 0)
        (change-brick-pos brick-lst))))
    (super-new))
